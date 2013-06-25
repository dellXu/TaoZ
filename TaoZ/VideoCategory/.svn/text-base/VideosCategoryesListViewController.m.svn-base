//
//  VideosCategoryesListViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-6-3.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "VideosCategoryesListViewController.h"
#import "BaseCell.h"
#import "md5Change.h"
#import "VideoClient.h"
#import "UIViewController+HideTabBar.h"
#import "VideoDetailViewController.h"
#import "ALTabBarController.h"
@interface VideosCategoryesListViewController ()

@end

@implementation VideosCategoryesListViewController
@synthesize pickerSheet;
@synthesize picker;
@synthesize isPickerShow;
@synthesize sourceArray;
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
    //[self hideTabBar:self.tabBarController];
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideTabBar];
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    [self.tableView setFrame:CGRectMake(self.view.bounds.origin.x,
                                        self.view.bounds.origin.y+42,
                                        320,
                                        rect.size.height-88.0-62+50)];
}
-(id)initWithVideoID:(NSString *)videoCategoryID {
    if (self = [self init]) {
        videoCategoryId = videoCategoryID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = [[UIScreen mainScreen]bounds];
    [self initTableViewWithRect:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y+42,
                                           rect.size.width,
                                           rect.size.height-88.0-62)];
    self.tableView.backgroundColor = [UIColor redColor];
    [self getSecVideoCategory];
    //默认请求全部（改categoryId下全部视频 并非资源库全部视频）3为最新上线
    [self loadVideoCategoryList:videoCategoryId orderId:@"3"];
    [self layOutHeaderView];
    
    // create the tableview
    
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
    
	// Do any additional setup after loading the view.
}

//左边按钮分类内容 由上级页面传入
-(void)setLeftButtonArray:(NSMutableArray *)secondTitleAry
{
    //secTitleAry = [[NSMutableArray alloc]initWithArray:secondTitleAry];
}
#pragma mark  获取二级菜单列表（左边button）
-(void)getSecVideoCategory
{
//    NSDictionary *dict = [[NSDictionary alloc]init];
//    dict = @{@"appkey":[md5Change md5:APPKEY],
//             @"pid":videoCategoryId,
//             @"all":@0};
//    
//    [[VideoClient instance]getVideoCategory:dict success:^(id sender) {
//        if (mVideoCategoryArray == nil)
//        {
//            mVideoCategoryArray = [[NSMutableArray alloc] init];
//        }
//        [mVideoCategoryArray addObjectsFromArray:[[sender objectForKey:@"datas"] objectForKey:@"lists"]];
//
//        NSLog(@"mVideoCategoryArray .count  == %d",mVideoCategoryArray.count);
//        Secdict = [[NSMutableDictionary alloc]init];
//        
//        [Secdict setObject:videoCategoryId forKey:@"全部"];
//        
//        for (int i =0; i<mVideoCategoryArray.count; i++) {
//            [Secdict setObject:[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"id"] forKey:[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"title"] ];
//            NSLog(@"dict = %@,%@",[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"id"],[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"title"]);
//            NSDictionary *abc = [[NSDictionary alloc]initWithObjectsAndKeys:[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"id"],[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"title"], nil];
//            
//        }//标题对应数字id
//        if (idary == nil)
//        {
//            idary = [[NSMutableArray alloc]init];
//        }
//        
//        for (id key in [Secdict allKeys])
//        {
//            [idary addObject:[Secdict objectForKey:key]];
//        }
//        //标题
//        secTitleAry = [[NSArray alloc]initWithArray:[Secdict allKeys]];
//        NSLog(@"dict = %@",Secdict);
//        NSLog(@"secTitleAry = %@",secTitleAry);
//        NSLog(@"title = %@",idary);
//    } failure:^(id sender) {
//        
//    }];
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"pid":videoCategoryId,
             @"all":@0};
    
    [[VideoClient instance]getVideoCategory:dict success:^(id sender) {
        if (mVideoCategoryArray == nil)
        {
            mVideoCategoryArray = [[NSMutableArray alloc] init];
        }
        [mVideoCategoryArray addObjectsFromArray:[[sender objectForKey:@"datas"] objectForKey:@"lists"]];
        
        NSLog(@"mVideoCategoryArray .count  == %d",mVideoCategoryArray.count);
        Secdict = [[NSMutableDictionary alloc]init];
        
        [Secdict setObject:videoCategoryId forKey:@"全部"];

        NSMutableArray *aaaa = [[NSMutableArray alloc]init];
        for (int i =0; i<mVideoCategoryArray.count; i++) {
            NSString *sssid = [[mVideoCategoryArray objectAtIndex:i] objectForKey:@"id"];
            NSString *ssstitle = [[mVideoCategoryArray objectAtIndex:i] objectForKey:@"title"];
            [Secdict setObject: sssid forKey: ssstitle];
            NSLog(@"dict = %@,%@",[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"id"],[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"title"]);
           // NSDictionary *abc = [[NSDictionary alloc]initWithObjectsAndKeys:[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"id"],[[mVideoCategoryArray objectAtIndex:i] objectForKey:@"title"], nil];
            //[aaaa addObject:[NSDictionary dictionaryWithObjectsAndKeys:sssid,ssstitle, nil]];
            NSArray *toary = [NSArray arrayWithObjects:sssid,ssstitle, nil];
            //[aaaa addObjectsFromArray:toary];
            [aaaa addObject:toary];
        }
        secTitleAry = [[NSMutableArray alloc]init];
        //添加全部选项 此处全部的意思是对应分类下的全部视频
        NSArray *allary =[NSArray arrayWithObjects:videoCategoryId,@"全部", nil];
        [aaaa insertObject:allary atIndex:0];
        for (int j=0; j<aaaa.count; j++) {
            //标题对应数字id
            if (idary == nil)
            {
                idary = [[NSMutableArray alloc]init];
            }
            //所有二级列表的对应id
            [idary addObject:[[aaaa objectAtIndex:j] objectAtIndex:0]];
            //所有二级列表的标题 用于pickView的内容
            [secTitleAry addObject:[[aaaa objectAtIndex:j] objectAtIndex:1]];
        }

    } failure:^(id sender) {
        
    }];
}


-(void)layOutHeaderView
{
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    headerImage.image = [UIImage imageNamed:@"videoCategoryListHead1.png"];
    headerImage.userInteractionEnabled = YES;
    [self.view addSubview:headerImage];
    
    leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
    [leftBtn setTitle:@"全部" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"videoCategoryListHead2.png"] forState:UIControlStateHighlighted];

    [headerImage addSubview:leftBtn];
    
    UIImageView *leftChoiceImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"videoCategoryList3.png"]];
    leftChoiceImage.frame = CGRectMake(0, 0, 17, 18);
    leftChoiceImage.center = CGPointMake(133, 20);
    
    [leftBtn addSubview:leftChoiceImage];
    
    
    rihgittBtn = [[UIButton alloc]initWithFrame:CGRectMake(160, 0, 160, 40)];
    [rihgittBtn setTitle:@"最新上线" forState:UIControlStateNormal];
    [rihgittBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [rihgittBtn addTarget:self action:@selector(rightBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [rihgittBtn setBackgroundImage:[UIImage imageNamed:@"videoCategoryListHead2.png"] forState:UIControlStateHighlighted];
    [headerImage addSubview:rihgittBtn];
    
    UIImageView *rightChoiceImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"videoCategoryList3.png"]];
    rightChoiceImage.frame = CGRectMake(0, 0, 17, 18);
    rightChoiceImage.center = CGPointMake(133, 20);
    [rihgittBtn addSubview:rightChoiceImage];
    
    [self layoutLeftPickView];
    
}
-(IBAction)leftBtnPressed:(id)sender
{
    [self pickerHideCancel];
    leftRitht = 1;
    [self setSourceArray:secTitleAry];
     [self pickerShow];
    [picker reloadAllComponents];
    [picker selectRow:0 inComponent:0 animated:YES];
}

-(IBAction)rightBtnPressed:(id)sender
{
    [self pickerHideCancel];
    leftRitht = 2;
    NSArray* array2 = [[NSArray alloc]initWithObjects: @"最新上线", @"点播最多",@"评论最多", nil];
    [self setSourceArray:array2];
    [self pickerShow];
    [picker reloadAllComponents];
    [picker selectRow:0 inComponent:0 animated:YES];
}
- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
								   screenRect.size.height - 44.0 - size.height,
								   size.width,
								   size.height);
	return pickerRect;
}


-(void)layoutLeftPickView
{
    

    CGRect rect = [[UIScreen mainScreen]bounds];
    CGRect frame = CGRectMake(0,rect.size.height, 320, 320);
	pickerSheet = [[UIActionSheet alloc] initWithFrame:frame];
	CGRect btnFrame = CGRectMake(10, 5, 60, 30);
	UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[cancelButton awakeFromNib];
	[cancelButton addTarget:self action:@selector(pickerHideCancel) forControlEvents:UIControlEventTouchUpInside];
	[cancelButton setFrame:btnFrame];
	cancelButton.backgroundColor = [UIColor clearColor];
	[cancelButton setTitle:@"取消" forState:UIControlStateNormal];
	[pickerSheet addSubview:cancelButton];
	
	CGRect btnOKFrame = CGRectMake(250, 5, 60, 30);
	UIButton* okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[okButton awakeFromNib];
	[okButton addTarget:self action:@selector(pickerHideOK) forControlEvents:UIControlEventTouchUpInside];
	[okButton setFrame:btnOKFrame];
	okButton.backgroundColor = [UIColor clearColor];
	[okButton setTitle:@"完成" forState:UIControlStateNormal];
	[pickerSheet addSubview:okButton];
	
	
	CGRect pickerFrame = CGRectMake(0, 40, 320, 200);
	picker=[ [UIPickerView alloc] initWithFrame:pickerFrame];
	picker.autoresizingMask=UIViewAutoresizingFlexibleWidth;
	picker.showsSelectionIndicator = YES;
	picker.delegate=self;
	picker.dataSource=self;
	picker.tag = 101;
	picker.hidden = NO;
	[pickerSheet addSubview:picker];
	[self.view addSubview:pickerSheet];

}



-(void)pickerShow
{
	if(!isPickerShow)
	{
		CGRect pickFrame = pickerSheet.frame;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.4f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[pickerSheet superview] cache:YES];
		pickFrame.origin.y -= pickFrame.size.height - 40;//应该根据应用动态计算需要的位置
		[pickerSheet setFrame:pickFrame];
		[UIView commitAnimations];
		isPickerShow = TRUE;
	}
}

#pragma mark pickerHideOK
-(void)pickerHideOK
{
	if(isPickerShow)//首先要隐藏，然后发送网络请求
	{
		CGRect pickFrame = pickerSheet.frame;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.4f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[pickerSheet superview] cache:YES];
		pickFrame.origin.y += pickFrame.size.height - 40;//应该根据应用动态计算需要的位置
		[pickerSheet setFrame:pickFrame];
		[UIView commitAnimations];
		isPickerShow = FALSE;
        
        //leftRitht表示选择的是左边还是右边的按钮，如何对对应的btn赋值
        NSString *str =nil;
        //a 表示选中的是哪行
        NSInteger a = [picker selectedRowInComponent:0];
        if (leftRitht == 1)
        {
            str = [self.sourceArray objectAtIndex:a];
            [leftBtn setTitle:str forState:UIControlStateNormal];
            
            NSLog(@"--==========-%@",[idary objectAtIndex:a]);
            
            NSString*categId = [Secdict objectForKey:leftBtn.titleLabel.text];
            [_dataSource removeAllObjects];
            [self loadVideoCategoryList:categId orderId:[self orderId]];
        }
        else if (leftRitht == 2)
        {
            str = [self.sourceArray objectAtIndex:a];
            [rihgittBtn setTitle:str forState:UIControlStateNormal];
            
            NSString*categId = [Secdict objectForKey:leftBtn.titleLabel.text];
            [_dataSource removeAllObjects];
            [self loadVideoCategoryList:categId orderId:[self orderId]];
        }

	}
}
#pragma mark pickerHideCancel
-(void)pickerHideCancel
{
	if(isPickerShow)
	{
		CGRect pickFrame = pickerSheet.frame;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.4f];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[pickerSheet superview] cache:YES];
		pickFrame.origin.y += pickFrame.size.height - 40;//应该根据应用动态计算需要的位置
		[pickerSheet setFrame:pickFrame];
		[UIView commitAnimations];
		isPickerShow = FALSE;

	}
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	return [self.sourceArray objectAtIndex:row];
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.sourceArray count];;
}


#pragma mark 2个排序选取器

#pragma mark 获取视频排行榜数据
-(void)loadVideoCategoryList:(NSString *)Id orderId:(NSString *)orderID
{
    //page 请求页码
    //limit 每页最大条数 默认15
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"category_id":Id,
             @"page":@1,
             @"order_id":orderID,
             @"limit":@15};
    [[VideoClient instance]getVideoCategorySecondList:dict success:^(id sender) {
        //self.videoRankingListArray = [[sender objectForKey:@"datas"] objectForKey:@"lists"];
        if (_dataSource == nil)
        {
            _dataSource = [[NSMutableArray alloc]init];
        }
        
        [_dataSource addObjectsFromArray:[[sender objectForKey:@"datas"] objectForKey:@"lists"]];
        
        //NSLog(@"---%@",_dataSource);
        NSLog(@"---%d",_dataSource.count);
        [_tableView reloadData];
    } failure:^(id sender) {
        
    }];
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
#pragma mark 获取目前选取的排序顺序
-(NSString *)orderId
{//", @"",@"
    NSString *ordID = nil;
    NSString *orName = rihgittBtn.titleLabel.text;
    if ([orName isEqualToString:@"最新上线"])
    {
        ordID = @"3";
    }
    else if ([orName isEqualToString:@"点播最多"])
    {
        ordID = @"1";
    }else if ([orName isEqualToString:@"评论最多"])
    {
        ordID = @"5";
    }
    return  ordID;
}
//下拉刷新
-(void)testRealRefreshDataSource{
    // NSInteger count = _dataSource?_dataSource.count:0;
    NSLog(@"_datasourece11111= %d",_dataSource.count);
    [_dataSource removeAllObjects];
    NSString*categId = [Secdict objectForKey:leftBtn.titleLabel.text];
    
    [self loadVideoCategoryList:categId orderId:[self orderId]];
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
