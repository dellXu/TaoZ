//
//  SearchViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-22.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "SearchViewController.h"
#import "UIViewController+HideTabBar.h"
#import "md5Change.h"
#import "VideoClient.h"
#import "SearchResultListViewController.h"
#import "ALTabBarController.h"

#define DBNAME      @"taoz.sqlite"
#define TABLENAME   @"searchTable"
#define SEARCHWORD  @"searchWord"
#define TOTAL       5 //数据库中最多存放多少条数据
@interface SearchViewController ()
@property(nonatomic,strong)UITextField *mSearchTextField;	//搜索输入框
@property(nonatomic,copy)NSDictionary *hotKeyDict;        //返回的热门搜索词字典
@property(nonatomic,copy)NSArray      *hotKeyArray;       //返回的热门搜索词列表
@property(nonatomic,retain)NSMutableArray *searchHistoryAry;//搜索历史数组

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    return self;
}
-(void)viewWillAppear:(BOOL)animated {
   //  [self hideTabBar:self.tabBarController];

     ALTabBarController *tab = (ALTabBarController *)self.tabBarController;


     [tab hideTabBar];
    [self dbGetDataFromDb];//读取数据库获取搜索历史
//    vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 800)];
//    vie.backgroundColor = [UIColor redColor];
//    [self.view addSubview:vie];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"---viewDidLoad -%f",vie.bounds.size.height);
    [self getSearchHotList];
    [self dbOpendatabase];//打开数据库
    [self layoutSearchInputView];
    
   // [self layoutButton];//绘制历史搜索按钮
    // Do any additional setup after loading the view from its nib.
}
-(void)layoutSearchInputView
{
    /* 绘制搜索输入框，添加相应事件 */
	_mSearchTextField = [[UITextField alloc]
                          initWithFrame:CGRectMake(0,0,200,30)];
	_mSearchTextField.borderStyle= UITextBorderStyleRoundedRect;
	_mSearchTextField.placeholder = @"搜索陶朱视频";
	_mSearchTextField.font  = [UIFont systemFontOfSize:20];
	[_mSearchTextField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
	self.navigationItem.titleView = _mSearchTextField;
    
    /* 设置右上角为搜索按钮 */
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                        handler:^(id sender) {
        [self searchButtonPressed];
    }];
    self.navigationItem.rightBarButtonItem = searchBarButtonItem;
    
	/* 设置左上角为返回按钮 */
	UIButton *pBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 17, 28)];
	pBackButton.backgroundColor = [UIColor clearColor];
	[pBackButton setBackgroundImage:[UIImage imageNamed:@"CommBack.png"] forState:UIControlStateNormal];
	[pBackButton addTarget:self
					action:@selector(backButtonPress)
		  forControlEvents:UIControlEventTouchUpInside];

    /* navigation leftBarButtonItem */
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                                      handler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
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
                      @"DELETE FROM '%@' WHERE %@ = '%@'",TABLENAME,SEARCHWORD,_mSearchTextField.text];
    [self execSql:sql1];
    //插入搜索记录
    NSString *sql2 = [NSString stringWithFormat:
                      @"INSERT INTO '%@' ('%@') VALUES ('%@')",TABLENAME,SEARCHWORD,_mSearchTextField.text];
    
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
    [self layoutButton];
}
#pragma mark 动态创建搜索历史按钮个数、赋值
-(void)layoutButton
{
    //NSArray *ary = @[@"1111",@"2222",@"3333",@"4444",@"5555",@"66666",@"77777",@"88888",@"9999",@"1111",@"11111"];
    
    
    //遍历scrollView 删除其上所有Button先，然后再绘制。用于历史搜索记录更新
    for (UIButton *bt in m_pTypeView.subviews ) {
        [bt removeFromSuperview];
    }
    
    int count = [self.searchHistoryAry count];
    /* 判断有多少行 */
	NSInteger nRow = (count % 2 > 0) ? (count / 2 + 1) : (count / 2);
    
    if (m_pTypeView == nil)
	{
		//m_pTypeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 320, 170)];
        m_pTypeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, 320, 570)];
        m_pTypeView.backgroundColor = [UIColor redColor];
        [m_pTypeView setContentSize:CGSizeMake(320,240)];
	}
	
	[m_pTypeView setBackgroundColor:[UIColor redColor]];
    if (nRow>0)
	{
		/* 根据按钮个数来改变view的高度 */
//		[m_pTypeView setFrame:CGRectMake(0, 200, 320, 170)];
        [m_pTypeView setFrame:CGRectMake(0, 200, 320, 570)];
        [m_pTypeView setContentSize:CGSizeMake(320,30 * nRow +20)];
	}
	else
	{
		[m_pTypeView setFrame:CGRectMake(0, 200, 320, 0)];
	}
    
	[self.view addSubview:m_pTypeView];
    
    int wi=0;//用于记录是哪个btn，便于赋值
	for (int i = 0; i < nRow; i++)
	{
		for (int j = 0; j < 2;j++)
		{
			if (count > i * 2 + j)
			{
                
				UIButton *typeButton = [[UIButton alloc] init];
				[typeButton setFrame:CGRectMake(26 + j * 166, 20 + i * 28, 105, 28)];
				[typeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                [typeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//				[typeButton setBackgroundImage:[UIImage imageNamed:@"apple.png"]
//									  forState:UIControlStateNormal];
//				[typeButton setBackgroundImage:[UIImage imageNamed:@"blackArrow.png"]
//									  forState:UIControlStateHighlighted];
				//[typeButton setTitle:[NSString stringWithFormat:@"%d",i * 2 + j]forState:UIControlStateNormal];
                [typeButton setTitle: [self.searchHistoryAry objectAtIndex:wi] forState:UIControlStateNormal];
                [typeButton addTarget:self action:@selector(typeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
				typeButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
				[typeButton setTag:i * 2 + j];
                [typeButton setBackgroundColor:[UIColor clearColor]];
				[m_pTypeView addSubview:typeButton];
                
                wi++;
                
			}
		}
	}
    for (UIButton *bt in m_pTypeView.subviews ) {
        NSLog(@"--------|tag| = %d",bt.tag);
    }
}


#pragma mark 搜索按钮触发事件
-(void)searchButtonPressed
{
    [_mSearchTextField resignFirstResponder];
    NSString *ssss = _mSearchTextField.text;
    if ([ssss isEqualToString:@""]||ssss == nil)
    {
        [UIAlertView showAlertViewWithTitle:@"搜索内容不能为空"
                                    message:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil
                                    handler:nil];
        return;
    }
    
    [self dbOperation];
    SearchResultListViewController *resultViewController = [[SearchResultListViewController alloc]initWithNibName:@"SearchResultListViewController" bundle:nil];
    [resultViewController getSearchKeyWord:ssss];
    [self.navigationController pushViewController:resultViewController animated:YES];
    sqlite3_close(db);
}

#pragma mark 历史搜索按钮点击事件
- (IBAction)typeButtonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *searchWord = btn.titleLabel.text;
    _mSearchTextField.text = searchWord;
    [self searchButtonPressed];

}

#pragma mark 热词搜索按钮点击事件
- (IBAction)hotSearchButtonPressed:(id)sender {
    [_mSearchTextField resignFirstResponder];
    UIButton *btn = (UIButton *)sender;
    NSString *ssss =btn.titleLabel.text;
    _mSearchTextField.text = ssss;
    [self searchButtonPressed];
}


#pragma mark 清空按钮点击事件
- (IBAction)clearSearchHistoryButtonPressed:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSLog(@"btnTag = %d,%@",btn.tag,btn.titleLabel.text);
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM '%@'",TABLENAME];
    [self execSql:sql];
    [self.searchHistoryAry removeAllObjects];
    [self layoutButton];
}


#pragma mark -
#pragma mark 按确认键关闭键盘
/***********************************************************************
 * 方法名称： - (IBAction)textFieldDoneEditing:(id)sender
 * 功能描述： 按确认键关闭键盘
 * 输入参数：
 * 输出参数：
 * 返 回 值： 空
 * 其它说明：
 ***********************************************************************/
- (IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}


-(void)hotSearchDicDidLoad:(NSDictionary *)hotDic {
    _hotKeyDict = hotDic;
}
-(void)hotSearchListDidLoad {
    _hotKeyArray = [[_hotKeyDict objectForKey:@"datas"] objectForKey:@"lists"];
}




#pragma mark 获取热门搜索词列表
-(void)getSearchHotList
{
    NSDictionary *dict = [[NSDictionary alloc]init];
    //limit 默认一页请求6个，因为热词搜索页只展示6个词条
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"limit":@"6"};
    [[VideoClient instance]getSearchHotkeyList:dict success:^(NSDictionary *listDict) {
        if (nil != listDict) {
            [self hotSearchDicDidLoad:listDict];
            [self hotSearchListDidLoad];
            int count = [_hotKeyArray count];
            if (count == 6)
            {
                [_hotButtonOne   setTitle:[[_hotKeyArray objectAtIndex:0]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonTwo   setTitle:[[_hotKeyArray objectAtIndex:1]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonThree setTitle:[[_hotKeyArray objectAtIndex:2]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonFour  setTitle:[[_hotKeyArray objectAtIndex:3]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonFive  setTitle:[[_hotKeyArray objectAtIndex:4]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonSix   setTitle:[[_hotKeyArray objectAtIndex:5]objectForKey:@"keyword"] forState:UIControlStateNormal];
            }else if (count == 5)
            {
                [_hotButtonOne   setTitle:[[_hotKeyArray objectAtIndex:0]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonTwo   setTitle:[[_hotKeyArray objectAtIndex:1]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonThree setTitle:[[_hotKeyArray objectAtIndex:2]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonFour  setTitle:[[_hotKeyArray objectAtIndex:3]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonFive  setTitle:[[_hotKeyArray objectAtIndex:4]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonSix setTitle:@"" forState:UIControlStateNormal];
                _hotButtonSix.userInteractionEnabled = NO;
            }else if (count == 4)
            {
                [_hotButtonOne   setTitle:[[_hotKeyArray objectAtIndex:0]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonTwo   setTitle:[[_hotKeyArray objectAtIndex:1]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonThree setTitle:[[_hotKeyArray objectAtIndex:2]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonFour  setTitle:[[_hotKeyArray objectAtIndex:3]objectForKey:@"keyword"] forState:UIControlStateNormal];
                
                [_hotButtonFive setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonSix setTitle:@"" forState:UIControlStateNormal];
                _hotButtonFive.userInteractionEnabled = NO;
                _hotButtonSix.userInteractionEnabled = NO;
            }else if (count == 3)
            {
                [_hotButtonOne   setTitle:[[_hotKeyArray objectAtIndex:0]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonTwo   setTitle:[[_hotKeyArray objectAtIndex:1]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonThree setTitle:[[_hotKeyArray objectAtIndex:2]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonFour setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonFive setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonSix setTitle:@"" forState:UIControlStateNormal];
                
                _hotButtonFour.userInteractionEnabled = NO;
                _hotButtonFive.userInteractionEnabled = NO;
                _hotButtonSix.userInteractionEnabled = NO;
            }else if (count == 2)
            {
                [_hotButtonOne   setTitle:[[_hotKeyArray objectAtIndex:0]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonTwo   setTitle:[[_hotKeyArray objectAtIndex:1]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonThree setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonFour setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonFive setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonSix setTitle:@"" forState:UIControlStateNormal];
                _hotButtonThree.userInteractionEnabled = NO;
                _hotButtonFour.userInteractionEnabled = NO;
                _hotButtonFive.userInteractionEnabled = NO;
                _hotButtonSix.userInteractionEnabled = NO;
            }else if (count == 1)
            {
                [_hotButtonOne   setTitle:[[_hotKeyArray objectAtIndex:0]objectForKey:@"keyword"] forState:UIControlStateNormal];
                [_hotButtonTwo setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonThree setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonFour setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonFive setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonSix setTitle:@"" forState:UIControlStateNormal];
                
                _hotButtonTwo.userInteractionEnabled = NO;
                _hotButtonThree.userInteractionEnabled = NO;
                _hotButtonFour.userInteractionEnabled = NO;
                _hotButtonFive.userInteractionEnabled = NO;
                _hotButtonSix.userInteractionEnabled = NO;
            }else if (count == 0)
            {
                [_hotButtonOne setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonTwo setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonThree setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonFour setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonFive setTitle:@"" forState:UIControlStateNormal];
                [_hotButtonSix setTitle:@"" forState:UIControlStateNormal];
                
                _hotButtonOne.userInteractionEnabled = NO;
                _hotButtonTwo.userInteractionEnabled = NO;
                _hotButtonThree.userInteractionEnabled = NO;
                _hotButtonFour.userInteractionEnabled = NO;
                _hotButtonFive.userInteractionEnabled = NO;
                _hotButtonSix.userInteractionEnabled = NO;
            }
            
        }else
        {
            [_hotButtonOne setTitle:@"" forState:UIControlStateNormal];
            [_hotButtonTwo setTitle:@"" forState:UIControlStateNormal];
            [_hotButtonThree setTitle:@"" forState:UIControlStateNormal];
            [_hotButtonFour setTitle:@"" forState:UIControlStateNormal];
            [_hotButtonFive setTitle:@"" forState:UIControlStateNormal];
            [_hotButtonSix setTitle:@"" forState:UIControlStateNormal];
            
            _hotButtonOne.userInteractionEnabled = NO;
            _hotButtonTwo.userInteractionEnabled = NO;
            _hotButtonThree.userInteractionEnabled = NO;
            _hotButtonFour.userInteractionEnabled = NO;
            _hotButtonFive.userInteractionEnabled = NO;
            _hotButtonSix.userInteractionEnabled = NO;
        }
        
        //NSLog(@"count = %d",[listDict obj]);
    } failure:^(NSString * error) {
        NSLog(@"");
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//如果程序中使用了navigationcontroller,那么需要自己继承自navigationcontroller，然后重写 - (BOOL)shouldAutorotate { return NO; } 和 - (BOOL)shouldAutorotateToInterfaceOrientation:UIInterfaceOrientation)interfaceOrientation { return UIInterfaceOrientationIsPortrait(interfa – xiaok 2013-01-17 10:10
- (void)viewDidUnload {
    [self setHotButtonOne:nil];
    [self setHotButtonTwo:nil];
    [self setHotButtonThree:nil];
    [self setHotButtonFour:nil];
    [self setHotButtonFive:nil];
    [self setHotButtonSix:nil];
    [self setHotButtonClear:nil];
    [self setHistoryButtonOne:nil];
    [self setHistoryButtonTwo:nil];
    [self setHistoryButtonThree:nil];
    [self setHistoryButtonFour:nil];
    [self setHistoryButtonFive:nil];
    [super viewDidUnload];
}
@end
