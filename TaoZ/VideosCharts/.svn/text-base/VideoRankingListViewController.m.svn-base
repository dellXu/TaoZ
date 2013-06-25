//
//  VideoRankingListViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-30.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "VideoRankingListViewController.h"
#import "md5Change.h"
#import "VideoClient.h"
#import "BaseCell.h"
#import "VideoDetailViewController.h"
#import "ALTabBarController.h"
@interface VideoRankingListViewController ()
@property(nonatomic,copy)NSArray *videoRankingListArray;//排行榜列表数组
@end

@implementation VideoRankingListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
  
       
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideExistingTabBar];
    
    W_M_T = @"7";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"排行榜";
     [self layOutView];
    [self getVideoRankList:@"7"];
    CGRect rect = [[UIScreen mainScreen]bounds];
    // create the tableview
    [self initTableViewWithRect:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y+42,
                                           rect.size.width,
                                           rect.size.height-88.0-62)];

    
    // [self getWeekRankList];
    _totalNumberOfRows = 100;
    _refreshCount = 0;
    //_dataSource = [[NSMutableArray alloc] initWithCapacity:15];
    _dataSource = [[NSMutableArray alloc] init];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10.0, 0);
    self.tableView.separatorStyle = NO;
    
    // set header
    [self createHeaderView];
    
    // the footer should be set after the data of tableView has been loaded, the frame of footer is according to the contentSize of tableView
    // here, actually begin too load your data, eg: from the netserver
    
    [self showRefreshHeader:YES];
    [self performSelector:@selector(testFinishedLoadData) withObject:nil afterDelay:2.0f];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 获取视频排行榜数据
-(void)getVideoRankList:(NSString *)days
{
    //day参数说明 7 周排行，30 月排行，0 总榜
    //page 请求页码
    //limit 每页最大条数 默认15
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"day":days,
             @"page":@1,
             @"limit":@15};
    [[VideoClient instance]getVideoRankList:dict success:^(id sender) {
        //self.videoRankingListArray = [[sender objectForKey:@"datas"] objectForKey:@"lists"];
        if (_dataSource == nil)
        {
            _dataSource = [[NSMutableArray alloc]init];
        }

        [_dataSource addObjectsFromArray:[[sender objectForKey:@"datas"] objectForKey:@"lists"]];

        
        NSLog(@"_datasourece__days== |%@|==%d",days,_dataSource.count);
        [_tableView reloadData];
    } failure:^(id sender) {
        
    }];
}

#pragma makr 绘制3个排行按钮
-(void)layOutView
{
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"videoChartsBg"]];
    [topImageView setFrame:CGRectMake(0, 0, 320, 40)];
    [self.view addSubview:topImageView];
    topImageView.userInteractionEnabled = YES;
    weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weekBtn setFrame:CGRectMake(0, 0, 106, 39)];
    [weekBtn setTitle: @"周排行" forState:UIControlStateNormal];
    weekBtn.titleLabel.textColor = [UIColor whiteColor];
    [weekBtn setBackgroundImage:[UIImage imageNamed:@"videoCharts"] forState:UIControlStateNormal];
    [weekBtn addTarget:self action:@selector(weekBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:weekBtn];
    
    monthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [monthBtn setFrame:CGRectMake(107, 0, 106, 39)];
    [monthBtn setTitle: @"月排行" forState:UIControlStateNormal];
    monthBtn.titleLabel.textColor = [UIColor blackColor];
    [monthBtn addTarget:self action:@selector(monthBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:monthBtn];
    
    TotalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [TotalBtn setFrame:CGRectMake(214, 0, 106, 39)];
    
    [TotalBtn setTitle:@"总榜" forState:UIControlStateNormal];
    TotalBtn.titleLabel.textColor = [UIColor blackColor];
    [TotalBtn addTarget:self action:@selector(TotalBtnPressed) forControlEvents:UIControlEventTouchUpInside];

    [topImageView addSubview:TotalBtn];
    
}

-(void)weekBtnPressed
{
   
    [weekBtn setBackgroundImage:[UIImage imageNamed:@"videoCharts"] forState:UIControlStateNormal];
    [monthBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [TotalBtn setBackgroundImage:nil forState:UIControlStateNormal];
    
    weekBtn.titleLabel.textColor = [UIColor whiteColor];
    monthBtn.titleLabel.textColor = [UIColor blackColor];
    TotalBtn.titleLabel.textColor = [UIColor blackColor];
    [_dataSource removeAllObjects];
    [self getVideoRankList:@"7"];
    W_M_T = @"7";
    
}

-(void)monthBtnPressed
{
    
    [monthBtn setBackgroundImage:[UIImage imageNamed:@"videoCharts"] forState:UIControlStateNormal];
    [weekBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [TotalBtn setBackgroundImage:nil forState:UIControlStateNormal];
    
    weekBtn.titleLabel.textColor = [UIColor blackColor];
    monthBtn.titleLabel.textColor = [UIColor whiteColor];
    TotalBtn.titleLabel.textColor = [UIColor blackColor];
    [_dataSource removeAllObjects];
    [self getVideoRankList:@"30"];
    W_M_T = @"30";
    
}

-(void)TotalBtnPressed
{
    
    [TotalBtn setBackgroundImage:[UIImage imageNamed:@"videoCharts"] forState:UIControlStateNormal];
    [weekBtn setBackgroundImage:nil forState:UIControlStateNormal];
    [monthBtn setBackgroundImage:nil forState:UIControlStateNormal];
    
    weekBtn.titleLabel.textColor = [UIColor blackColor];
    monthBtn.titleLabel.textColor = [UIColor blackColor];
    TotalBtn.titleLabel.textColor = [UIColor whiteColor];
    [_dataSource removeAllObjects];
    [self getVideoRankList:@"0"];
    W_M_T = @"0";
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark overide UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource?1:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource?_dataSource.count:0;
}
#pragma mark TableView 委托方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *searchResultListTableIdentifier = @"baseCellIdentifier";
    BaseCell *cell = (BaseCell *)[tableView dequeueReusableCellWithIdentifier:searchResultListTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BaseCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell setBackgroundView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123123.png"]]];
    }
    cell.mIntroduce.text = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"brief"];
    cell.mTitle.text = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.mPlayCount.text = [NSString stringWithFormat:@"%@",[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"play_count"]];
    NSURL *imgUrl = [NSURL URLWithString:[[_dataSource objectAtIndex:indexPath.row] objectForKey:@"imgurl"]];
    [cell.mThumbnail setImageWithURL:imgUrl];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *guid = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"guid"];
    VideoDetailViewController *detail = [[VideoDetailViewController alloc]initWithVideoID:guid];
    [detail setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark-
#pragma mark overide methods
-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	[super beginToReloadData:aRefreshPos];
    
    if (aRefreshPos == EGORefreshHeader) {
        // pull down to refresh data
        [self performSelector:@selector(testRealRefreshDataSource) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter){
        // pull up to load more data
        [self performSelector:@selector(testRealLoadMoreData) withObject:nil afterDelay:2.0];
    }
}
//下拉刷新
-(void)testRealRefreshDataSource{
   // NSInteger count = _dataSource?_dataSource.count:0;
     NSLog(@"_datasourece11111= %d",_dataSource.count);
    [_dataSource removeAllObjects];
//    _refreshCount ++;
//    
//    for (int i = 0; i < count; i++) {
//        NSString *newString = [NSString stringWithFormat:@"%d_new label number %d", _refreshCount,i];
//        [_dataSource addObject:newString];
//    }
    [self getVideoRankList:W_M_T];
    // after refreshing data, call finishReloadingData to reset the header/footer view
    [_tableView reloadData];
    [self finishReloadingData];
}
//上拉加载更多
-(void)testRealLoadMoreData{
//    NSInteger count = _dataSource?_dataSource.count:0;
//    NSString *stringFormat;
//    if (_refreshCount == 0) {
//        stringFormat = @"label number %d";
//    }else {
//        stringFormat = [NSString stringWithFormat:@"%d_new label number ", _refreshCount];
//        stringFormat = [stringFormat stringByAppendingString:@"%d"];
//    }
//    
//    for (int i = 0; i < 20; i++) {
//        NSString *newString = [NSString stringWithFormat:stringFormat, i+count];
//        if (_dataSource == nil) {
//            _dataSource = [[NSMutableArray alloc] initWithCapacity:4];
//            
//        }
//        [_dataSource addObject:newString];
//    }
//    
//    _loadMoreCount ++;
//    
//    // after refreshing data, call finishReloadingData to reset the header/footer view
//    if (_loadMoreCount > 3) {
//        [self finishReloadingData];
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
//        [self removeFooterView];
//    }else{
//        [_tableView reloadData];
//        [self finishReloadingData];
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
//        [self setFooterView];
//    }
}

-(void)testFinishedLoadData{
//    for (int i = 0; i < 20; i++) {
//        NSString *tableString = [NSString stringWithFormat:@"label number %d", i];
//        [_dataSource addObject:tableString];
//    }
//    
    // after loading data, should reloadData and set the footer to the proper position
    [self.tableView reloadData];
    [self finishReloadingData];
    [self setFooterView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
