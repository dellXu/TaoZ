//
//  SearchResultListViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-23.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "SearchResultListViewController.h"
#import "UIViewController+HideTabBar.h"
#import "BaseCell.h"
#import "md5Change.h"
#import "VideoClient.h"
#import "VideoDetailViewController.h"
#import "ALTabBarController.h"

#define DBNAME      @"taoz.sqlite"
#define TABLENAME   @"searchTable"
#define SEARCHWORD  @"searchWord"
#define TOTAL       5 //数据库中最多存放多少条数据
@interface SearchResultListViewController ()
@property(nonatomic,copy)NSString *searchkeyWord;
@property(nonatomic,copy)NSArray *videoListAry;
@property(nonatomic,retain)NSMutableArray *searchHistoryAry;//搜索历史数组
@end

@implementation SearchResultListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
   // [self hideTabBar:self.tabBarController];
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideTabBar];
    
  
    
    
    [self dbGetDataFromDb];//读取数据库获取搜索历史
    NSLog(@"---view = %f",self.view.bounds.size.height);
    NSLog(@"---tableview = %f",self.searchResultTableView.bounds.size.height);
}

#pragma mark 获取数据库中搜索历史记录的最近5条
-(void)dbGetDataFromDb
{
    //获取全部数据
    NSString *sqlQuery = @"SELECT searchWord FROM searchTable";
    sqlite3_stmt * statement;
    self.searchHistoryAry = [[NSMutableArray alloc] init];
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *word = (char*)sqlite3_column_text(statement, 0);
            NSString *nsWordStr = [[NSString alloc]initWithUTF8String:word];
            [self.searchHistoryAry addObject:nsWordStr];
            
        }
    }
    NSLog(@"mSearchArray = %@",_searchHistoryAry);
}

#pragma mark 打开/创建数据库
-(void)dbOpendatabase
{
    //在ios5系统后，数据库明确要求放在Caches文件夹目录下了。不然审核通不过
    NSString * documents =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES) objectAtIndex:0];
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    //open database
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
        return;
    }
    //create table
    NSString *sqlCreateTable = @"CREATE TABLE IF NOT EXISTS searchTable (ID INTEGER PRIMARY KEY AUTOINCREMENT,searchWord TEXT)";
    [self execSql:sqlCreateTable];
}

//思想：1、若无表，则创建表 2、为防止数据重复，先删除要插入的数据，然后再插入数据 3、若超过总条数现在，则删除最旧的数据
-(void)dbOperation
{
    //预防插入重复数据，先删除表内相关数据（若存在则被删除)
    NSString *sql1 = [NSString stringWithFormat:
                      @"DELETE FROM '%@' WHERE %@ = '%@'",TABLENAME,SEARCHWORD,_mSearchBar.text];
    [self execSql:sql1];
    //插入搜索记录
    NSString *sql2 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@') VALUES ('%@')",TABLENAME,SEARCHWORD,_mSearchBar.text];
    
    [self execSql:sql2];
    
    //获取全部数据
    NSString *sqlQuery = @"SELECT searchWord FROM searchTable";
    sqlite3_stmt * statement;
    NSMutableArray *mSearchArray = [[NSMutableArray alloc] init];
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *word = (char*)sqlite3_column_text(statement, 0);
            NSString *nsWordStr = [[NSString alloc]initWithUTF8String:word];
            [mSearchArray addObject:nsWordStr];
            NSLog(@"mSearchArray = %@",mSearchArray);
        }
    }
    
    //数据库内记录达到上限后，删除最旧数据
    if ([mSearchArray count] > TOTAL)
    {
        NSString *str = [mSearchArray objectAtIndex:0];
        NSString *sql3 = [NSString stringWithFormat:
                          @"DELETE FROM '%@' WHERE %@ = '%@'",TABLENAME,SEARCHWORD,str];
        [self execSql:sql3];
    }
    
}

//执行数据库语句
-(void)execSql:(NSString *)sql
{
    char *err;
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK)
    {
        sqlite3_close(db);
        NSLog(@"数据库操作失败");
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self dbOpendatabase];
    _searchResultTableView.delegate = self;
    _searchResultTableView.dataSource = self;
    _searchResultTableView.separatorStyle = NO;
    [self getVideoListBykeword];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getSearchKeyWord:(NSString *)searchKeyWord
{
    self.searchkeyWord = searchKeyWord;
}
- (void)viewDidUnload {
    [self setMSearchBar:nil];
    [self setSearchResultTableView:nil];
    [super viewDidUnload];
}
//根据搜索返回结果调整表头提示语
-(void)searchResultMessage:(NSDictionary *)result
{
    NSString *str = nil;
    int  ret = [[result objectForKey:@"ret"] intValue];

    if (ret == 1)
    {
 
        str = [NSString stringWithFormat:@"关于“%@”共有%d个相关视频",_searchkeyWord,[_videoListAry count]];
        
        CGSize labelSize = [str sizeWithFont:[UIFont boldSystemFontOfSize:15.0f]
                           constrainedToSize:CGSizeMake(270, 50)
                               lineBreakMode:UILineBreakModeCharacterWrap];   // str是要显示的字符串
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 50, labelSize.width, labelSize.height)];
        infoLabel.text = str;
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.font = [UIFont systemFontOfSize:15.0f];
        infoLabel.numberOfLines = 0;// 不可少Label属性之一
        infoLabel.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
        [self.view addSubview:infoLabel];
        
        
        CGRect rect = [[UIScreen mainScreen]bounds];
        float yyy = rect.size.height-infoLabel.frame.size.height-120+48;
        //根据infoLabel高度来调整列表坐标 _searchResultTableView.frame.size.height
        [_searchResultTableView setFrame:CGRectMake(0, infoLabel.frame.origin.y+30, _searchResultTableView.frame.size.width, yyy)];
        NSLog(@"---yyy = %f",yyy);
    }
    else if (ret == -1)
    {
        str = [NSString stringWithFormat:@"很抱歉，暂时没有关于“%@”的视频，我们为您推荐以下视频，您也可以重新搜索",_searchkeyWord];
        // str = [NSString stringWithFormat:@"关于“%@”共有%d个相关视频",_searchkeyWord,[_videoListAry count]];
        
        CGSize labelSize = [str sizeWithFont:[UIFont boldSystemFontOfSize:13.0f]
                           constrainedToSize:CGSizeMake(250, 70)
                               lineBreakMode:UILineBreakModeCharacterWrap];   // str是要显示的字符串
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(62, 45, labelSize.width, labelSize.height)];
        infoLabel.text = str;
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.font = [UIFont systemFontOfSize:13.0f];
        infoLabel.numberOfLines = 0;// 不可少Label属性之一
        infoLabel.lineBreakMode = UILineBreakModeCharacterWrap;// 不可少Label属性之二
        [self.view addSubview:infoLabel];
        
        infoImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 50, labelSize.height-5, labelSize.height-5)];
        infoImage.image = [UIImage imageNamed:@"apple.png"];
        [self.view addSubview:infoImage];
        
        CGRect rect = [[UIScreen mainScreen]bounds];
        float yyy = rect.size.height-infoLabel.frame.size.height-120;
        //根据infoLabel高度来调整列表坐标 _searchResultTableView.frame.size.height
        [_searchResultTableView setFrame:CGRectMake(0, infoLabel.frame.origin.y+5+44, _searchResultTableView.frame.size.width, yyy)];
         NSLog(@"---yyy = %f",yyy);
    }

}
//获取的数据存入videoListAry
-(void)loadVideoList:(id)sender
{
    self.videoListAry = [[sender objectForKey:@"datas"] objectForKey:@"lists"];
    [self searchResultMessage:sender];
    [_searchResultTableView reloadData];
}
#pragma mark 获取关键字搜索结果
-(void)getVideoListBykeword
{
    if (_searchkeyWord == nil)
    {
        _searchkeyWord = @"";
    }
    NSDictionary *dict = [[NSDictionary alloc]init];
    //limit 默认一页请求15个
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"k":_searchkeyWord,
             @"page":@"1",
             @"limit":@"15"};
    [[VideoClient instance]getSearchListByKeyWord:dict success:^(id sender) {
        [self loadVideoList:sender];
 
    } failure:^(id sender) {
        NSLog(@"3333333"); 
    }];
}
#pragma mark TableView 委托方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_videoListAry count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *guid = [[_videoListAry objectAtIndex:indexPath.row] objectForKey:@"guid"];
    VideoDetailViewController *detail = [[VideoDetailViewController alloc]initWithVideoID:guid];
    [self.navigationController pushViewController:detail animated:YES];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *searchResultListTableIdentifier = @"baseCellIdentifier";
    BaseCell *cell = (BaseCell *)[tableView dequeueReusableCellWithIdentifier:searchResultListTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BaseCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123123.png"]]];
    }
    cell.mIntroduce.text = [[_videoListAry objectAtIndex:indexPath.row] objectForKey:@"brief"];
    cell.mTitle.text = [[_videoListAry objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.mPlayCount.text = [NSString stringWithFormat:@"%@",[[_videoListAry objectAtIndex:indexPath.row] objectForKey:@"play_count"]];
    NSURL *imgUrl = [NSURL URLWithString:[[_videoListAry objectAtIndex:indexPath.row] objectForKey:@"imgurl"]];
    [cell.mThumbnail setImageWithURL:imgUrl];
    return cell;
    
}
#pragma mark 搜索框委托方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    infoLabel.text = nil;
    NSString *searchWord = searchBar.text;
    [self.mSearchBar resignFirstResponder];
    if ([searchWord isEqualToString:@""]||searchWord == nil)
    {
        [UIAlertView showAlertViewWithTitle:@"搜索内容不能为空"
                                    message:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil
                                    handler:nil];
        return;
    }
    _searchkeyWord = _mSearchBar.text;
    infoImage.image = nil;
    [self dbOperation];
    [self getVideoListBykeword];
    
    
    sqlite3_close(db);
}
@end
