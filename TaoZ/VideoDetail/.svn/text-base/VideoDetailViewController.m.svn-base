//
//  VideoDetailViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-28.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "BaseCell.h"
#import "VideoClient.h"
#import "md5Change.h"
#import "getUserInfo.h"
#import "MemberIntroduceViewController.h"
#import "LoginViewController.h"
#import "DAKeyboardControl.h"
#import "ALTabBarController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface VideoDetailViewController ()
@property(nonatomic,copy)NSString *videoGuid;
@property(nonatomic,copy)NSDictionary *videoDetailDic;
@property(nonatomic,copy)NSArray *relatedVideoArray;
@property(nonatomic,copy)NSArray *userCommentArray;
@property(nonatomic,assign)NSInteger commentCount;
@property(nonatomic,assign)BOOL isFavorite;
@property(nonatomic,copy)NSString *str;
@end

@implementation VideoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithVideoID:(NSString *)videoGUID {
    if (self = [self init]) {
        self.videoGuid = videoGUID;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideTabBar];
    [self getUserAllInfo];
    [self layoutVideoDetailView];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self getUserAllInfo];
//    [self layoutVideoDetailView];
    
    [self loadVideoIntroduceView];
    [self loadDetailView];
    [self defaultButtonSelected];
    [self loadVideoDetail];
    [self isFavoriteVideo];
    [self layoutKeyBoard];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark  根据用户登录状态、是否是会员绘制界面
-(void)layoutVideoDetailView
{
    if (!isLogin)
    {
        [self.videoPlayNowButton setBackgroundImage:[UIImage imageNamed:@"videoDetailJoin1.png"] forState:UIControlStateNormal];
        [self.videoPlayNowButton setBackgroundImage:[UIImage imageNamed:@"videoDetailJoin2.png"] forState:UIControlStateHighlighted];
        [self.videoPlayNowButton setTitle:@"加入我们" forState:UIControlStateNormal];
        self.videoPlayNowButton.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    else
    {
        [self.videoPlayNowButton setBackgroundImage:[UIImage imageNamed:@"videoDetailPlaynow1.png"] forState:UIControlStateNormal];
        [self.videoPlayNowButton setBackgroundImage:[UIImage imageNamed:@"videoDetailPlaynow2.png"] forState:UIControlStateHighlighted];
        [self.videoPlayNowButton setTitle:@"马上观看" forState:UIControlStateNormal];
        self.videoPlayNowButton.titleLabel.font = [UIFont systemFontOfSize:17];
        if (userInfoIsVip == 0)
        {
            UIButton *becomeVIPBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 72, 29)];
            becomeVIPBtn.backgroundColor = [UIColor clearColor];
            [becomeVIPBtn setTitle:@"成为会员" forState:UIControlStateNormal];
            [becomeVIPBtn setTintColor:[UIColor whiteColor]];
            becomeVIPBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [becomeVIPBtn setBackgroundImage:[UIImage imageNamed:@"becomeVip1.png"] forState:UIControlStateNormal];
            [becomeVIPBtn setBackgroundImage:[UIImage imageNamed:@"becomeVip2.png"] forState:UIControlStateHighlighted];
            [becomeVIPBtn addTarget:self
                            action:@selector(becomeVIPBtnPressed)
                  forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:becomeVIPBtn];
            self.navigationItem.rightBarButtonItem = backBarButtonItem;
        }
    }
    [self.videoPlayNowButton addTarget:self action:@selector(videoPlayNowButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 成为会员按钮触发事件
-(void)becomeVIPBtnPressed
{
    MemberIntroduceViewController *memberView = [[MemberIntroduceViewController alloc] init];
    [self.navigationController pushViewController:memberView animated:YES];
}
#pragma mark 播放、加入我们按钮触发事件
-(void)videoPlayNowButtonPressed
{
    if (isLogin)//已登录 点击播放
    {
        // 如果满足播放条件play video
        if (userInfoIsVip == 1 && userMoney < 1)//是会员，但是观看条数不足
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"尊敬的用户,您的观看条数不足,请续费后观看"
                                                           delegate:self
                                                  cancelButtonTitle:@"以后再说"
                                                  otherButtonTitles:@"现在续费", nil];
            alert.tag = 10011;
            [alert show];
        }
        if (userInfoIsVip == 0)//不是会员 提示开通会员
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"您还不是会员,成为会员后才能观看"
                                                           delegate:self
                                                  cancelButtonTitle:@"以后再说"
                                                  otherButtonTitles:@"确定开通", nil];
            alert.tag = 10012;
            [alert show];
        }
        else
        {
            NSLog(@"Play``````");
            //请求视频的cc视频id

            NSDictionary *dict = [[NSDictionary alloc]init];
            //limit 每页最大条数，默认15
            dict = @{@"appkey":[md5Change md5:APPKEY],
                     @"video_guid":self.videoGuid,
                     @"user_guid":userInfoGUID,
                     @"to_pay":@0};
            [[VideoClient instance]getVideoPlayInfo:dict success:^(id sender) {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:sender];
                int ret = [[dic objectForKey:@"ret"] integerValue];
                if (ret == 1)
                {
                    NSString *videoCCID = [[dic objectForKey:@"datas"] objectForKey:@"video_uid"];
                    NSLog(@"videoCCID = %@",videoCCID);
                    ///////
                    ///////
                    ///////
                    ///////根据videoCCID 来播放视频
                }else if (ret == -10)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"本次学习将扣除您1个观看条数，祝您学习愉快，赢得未来。"
                                                                   delegate:self
                                                          cancelButtonTitle:@"以后再说"
                                                          otherButtonTitles:@"继续学习", nil];
                    alert.tag = 10020;
                    [alert show];
                }else if (ret == -11)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"本视频3次观看机会已用完，您需要扣除1个观看条数来继续观看"
                                                                   delegate:self
                                                          cancelButtonTitle:@"以后再说"
                                                          otherButtonTitles:@"继续学习", nil];
                    alert.tag = 10021;
                    [alert show];
                }
             
            } failure:^(id sender) {
                
            }];
            
        }

    }
    else//未登录 提示需要登录
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"登录后才能完成指定操作"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"马上登录", nil];
        alert.tag = 10010;
        [alert show];
    }
}
#pragma mark UIAlertView委托事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10010)//10010 提示需要登录alerview
    {
        if (buttonIndex == 1)
        {
             UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MyTaozViewController" bundle:nil];
            UIViewController * login  = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    else if (alertView.tag == 10011)//10011 提示续费alertview
    {
        [self becomeVIPBtnPressed];
    }
    else if (alertView.tag == 10012)//10012 不是会员 提示开通会员
    {
        [self becomeVIPBtnPressed];
    }
    else if (alertView.tag == 10020)//10020 提示用户需要扣除学习条数来观看视频
    {
        if (buttonIndex == 1)
        {
            NSDictionary *dict = [[NSDictionary alloc]init];
            //limit 每页最大条数，默认15
            dict = @{@"appkey":[md5Change md5:APPKEY],
                     @"video_guid":self.videoGuid,
                     @"user_guid":userInfoGUID,
                     @"to_pay":@1};
            [[VideoClient instance]getVideoPlayInfo:dict success:^(id sender) {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:sender];
                int ret = [[dic objectForKey:@"ret"] integerValue];
                if (ret == 1)
                {
                    NSString *videoCCID = [[dic objectForKey:@"datas"] objectForKey:@"video_uid"];
                    NSLog(@"videoCCID = %@",videoCCID);
                    ///////
                    ///////
                    ///////
                    ///////根据videoCCID 来播放视频
                }
            } failure:^(id sender) {
                
            }];
        }
    }else if (alertView.tag == 10021)//10021 3次播放机会用完，提示用户需要扣除学习条数来观看视频
    {
        if (buttonIndex == 1)
        {
            NSDictionary *dict = [[NSDictionary alloc]init];
            //limit 每页最大条数，默认15
            dict = @{@"appkey":[md5Change md5:APPKEY],
                     @"video_guid":self.videoGuid,
                     @"user_guid":userInfoGUID,
                     @"to_pay":@1};
            [[VideoClient instance]getVideoPlayInfo:dict success:^(id sender) {
                NSDictionary *dic = [NSDictionary dictionaryWithDictionary:sender];
                int ret = [[dic objectForKey:@"ret"] integerValue];
                if (ret == 1)
                {
                    NSString *videoCCID = [[dic objectForKey:@"datas"] objectForKey:@"video_uid"];
                    NSLog(@"videoCCID = %@",videoCCID);
                    ///////
                    ///////
                    ///////
                    ///////根据videoCCID 来播放视频
                }
            } failure:^(id sender) {
                
            }];
        }
    }

}
#pragma mark  获取用户信息
-(void)getUserAllInfo
{
    NSDictionary *userinfoDic = [[NSDictionary alloc]init];
    getUserInfo *getinfo = [getUserInfo alloc];
    userinfoDic = [getinfo getUserUserInfo];
    if (userinfoDic != nil)
    {
        isLogin = YES;
        userInfoIsVip = [[userinfoDic objectForKey:@"is_vip"] integerValue];  //0否  1是
        userInfoGUID = [userinfoDic objectForKey:@"guid"];
        userInfoID  = [[userinfoDic objectForKey:@"id"] integerValue];
        userMoney = [[userinfoDic objectForKey:@"user_money"]integerValue];
        NSLog(@"~~~~~~userinfoDic ~~~ = %@",userinfoDic);
    }
    else {
        isLogin = NO;
    }
    
}
-(void)loadVideoDetail
{
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"guid":self.videoGuid};
    [[VideoClient instance]getVideoDetailByGuid:dict success:^(id sender) {
        //返回有数据则显示相关数据
        if ([sender objectForKey:@"ret"] ==[NSNumber numberWithInt:1]) {
            self.videoDetailDic =[sender objectForKey:@"datas"];
            self.videoDetailNameLabel.text = [_videoDetailDic objectForKey:@"title"];
            self.videoBuyCountLabel.text = [[_videoDetailDic objectForKey:@"play_count"] stringValue];
            self.videoLikeCount.text = [[_videoDetailDic objectForKey:@"favorite_count"] stringValue];
            videoIntroduceTextView.text = [_videoDetailDic objectForKey:@"detail"];
            NSURL *imgUrl = [NSURL URLWithString:[_videoDetailDic objectForKey:@"imgurl"]];
            [self.videoDetailImage setImageWithURL:imgUrl];
        }
        else
        {     
            [UIAlertView showAlertViewWithTitle:@""
                                        message:@"无此视频相关信息"
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil
                                        handler:nil];
        }
       
    } failure:^(id sender) {
        
    }];
}
#pragma mark 默认选择视频介绍按钮
-(void)defaultButtonSelected
{
    [_videoIntroduceButton setBackgroundImage:[UIImage imageNamed:@"videoDetailIntrocude.png"] forState:UIControlStateNormal];
    [_relatedVideoButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_userCommentButton setBackgroundImage:nil forState:UIControlStateNormal];
    
}
#pragma mark 根据屏幕大小绘制视频介绍textView 、分享、收藏、评论按钮
-(void)loadVideoIntroduceView
{
     CGRect rect = [[UIScreen mainScreen]bounds];
     
    videoIntroduceTextView = [[UITextView alloc]initWithFrame:CGRectMake(5, 190, 310, rect.size.height-183-50-55-10-8)];
    videoIntroduceTextView.editable = NO;
    videoIntroduceTextView.font = [UIFont systemFontOfSize:15];
    videoIntroduceTextView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:235.0f/255.0f alpha:1.0];
   // videoIntroduceTextView.backgroundColor = UIColorFromRGB(0xf0efeb);
    [self.view addSubview:videoIntroduceTextView];
    
    //底部view
    opearImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, rect.size.height-114, 320, 50)];
    opearImageView.image = [UIImage imageNamed:@"videoDetailtoolbar.png"];
    opearImageView.userInteractionEnabled = YES;
    [self.view addSubview:opearImageView];
    
    //分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 5, 54, 47);
    shareBtn.center = CGPointMake(70, 25);
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"videoDetailshareicon1.png"] forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"videoDetailshareicon2.png"] forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(videoShareButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [opearImageView addSubview:shareBtn];
    
    
    //收藏按钮
    likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    likeBtn.frame = CGRectMake(0, 5, 54, 47);
    likeBtn.center = CGPointMake(160, 25);
    [likeBtn setBackgroundImage:[UIImage imageNamed:@"videoDetailL1.png"] forState:UIControlStateNormal];
    [likeBtn setBackgroundImage:[UIImage imageNamed:@"videoDetailL2.png"] forState:UIControlStateHighlighted];
    [likeBtn addTarget:self action:@selector(videoLikeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [opearImageView addSubview:likeBtn];
    
    //评论按钮
    UIButton *userCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userCommentBtn.frame = CGRectMake(0, 5, 54, 47);
    userCommentBtn.center = CGPointMake(250, 25);
    [userCommentBtn setBackgroundImage:[UIImage imageNamed:@"videoDetailCom1.png"] forState:UIControlStateNormal];
    [userCommentBtn setBackgroundImage:[UIImage imageNamed:@"videoDetailCom2.png"] forState:UIControlStateHighlighted];
    [userCommentBtn addTarget:self action:@selector(videoCommentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [opearImageView addSubview:userCommentBtn];
}
-(void)videoShareButtonPressed
{
    NSLog(@"111111111");
}

-(IBAction)videoLikeButtonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
//    getUserInfo *getuserID =  [[getUserInfo alloc] init];
//    
//    NSString *userID = [NSString stringWithFormat:@"%ld",[getuserID getUserUserid]];
//    
//    if ([userID isEqualToString:@"-1"])
//    {
//        [UIAlertView showAlertViewWithTitle:@"尚未登录，请登录"
//                                    message:nil
//                          cancelButtonTitle:@"OK"
//                          otherButtonTitles:nil
//                                    handler:nil];
//    }
    if(userInfoID == 0)
    {
        [UIAlertView showAlertViewWithTitle:@"尚未登录，请登录"
                                    message:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil
                                    handler:nil];
    }
    NSString *userID = [NSString stringWithFormat:@"%d",userInfoID];
    NSDictionary *dict = [[NSDictionary alloc]init];
    //limit 每页最大条数，默认15
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"video_guid":self.videoGuid,
             @"user_id":userID};
    
    //如果已收藏，则删除收藏
    if(self.isFavorite)
    {
        [[VideoClient instance] deleteFavoriteVideo:dict success:^(id sender) {
            if ([sender objectForKey:@"ret"] == [NSNumber numberWithInt:1] )
            {
                NSLog(@"删除收藏成功");
                [self.view makeToast:@"已取消收藏！" duration:2.5f position:@"center"];
                self.isFavorite = NO;
                [btn setBackgroundImage:[UIImage imageNamed:@"videoDetailL1.png"] forState:UIControlStateNormal];
            }
        } failure:^(id sender) {
            
        }];
    }
    //如果没收藏，则收藏
    else
    {
        [[VideoClient instance] addFavoriteVideo:dict success:^(id sender) {
            if ([sender objectForKey:@"ret"] == [NSNumber numberWithInt:1] )
            {
                //NSLog(@"收藏成功");
                [self.view makeToast:@"收藏成功了！" duration:2.5f position:@"center"];
                self.isFavorite = YES;
                [btn setBackgroundImage:[UIImage imageNamed:@"videoDetailL3.png"] forState:UIControlStateNormal];
            }
        } failure:^(id sender) {
            
        }];

    }
    
        
}
#pragma mark 视频是否已收藏
-(void)isFavoriteVideo
{
    getUserInfo *getuserID =  [[getUserInfo alloc] init];
    
    NSString *userID = [NSString stringWithFormat:@"%ld",[getuserID getUserUserid]];
    
    if ([userID isEqualToString:@"-1"])
    {
        [UIAlertView showAlertViewWithTitle:@"尚未登录，请登录"
                                    message:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil
                                    handler:nil];
    }
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"video_guid":self.videoGuid,
             @"user_id":userID};
    [[VideoClient instance]isFavoriteVideo:dict success:^(id sender) {
        
        id abcd = [sender objectForKey:@"ret"];
        NSString *ddd = [abcd stringValue];
  
        if ([ddd isEqualToString:@"1"] )
         {
             self.isFavorite = YES;
             
             [likeBtn setBackgroundImage:[UIImage imageNamed:@"videoDetailL3.png"] forState:UIControlStateNormal];
         }
        else if ([ddd isEqualToString:@"-4"] )
        {
            self.isFavorite = NO;
            //[self.view makeToast:@"收藏失败" duration:2.5f position:@"center"];
            [likeBtn setBackgroundImage:[UIImage imageNamed:@"videoDetailL1.png"] forState:UIControlStateNormal];
        }
    } failure:^(id sender) {
        
    }];

}


-(void)videoCommentButtonPressed
{
    i =1;
    [textView becomeFirstResponder];
}
#pragma mark 绘制视频介绍，相关视频，用户评论下的控件 控制隐藏，防止重复绘制
-(void)loadDetailView
{
    //相关视频
    CGRect rect = [[UIScreen mainScreen]bounds];
    relatedVideoTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 190, 310, rect.size.height-183-50-55-10-10)];
    relatedVideoTableView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:235.0f/255.0f alpha:1.0];
    relatedVideoTableView.delegate = self;
    relatedVideoTableView.dataSource = self;
    [self.view addSubview:relatedVideoTableView];
    relatedVideoTableView.hidden = YES;
    
    
    //绘制用户评论列表、评论总数
    commentTotal = [[UILabel alloc]initWithFrame:CGRectMake(5, 185, 250, 38)];
    commentTotal.backgroundColor = [UIColor clearColor];
    [self.view addSubview:commentTotal];
    commentTotal.hidden = YES;
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"videoDetailOther1.png"]];
    imageview.frame = CGRectMake(0, 10, 5, 18);
    [commentTotal addSubview:imageview];
    userCommentTableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 223, 300, rect.size.height-183-50-55-10-20-10-5-5)];
    userCommentTableView.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:239.0f/255.0f blue:235.0f/255.0f alpha:1.0];
    userCommentTableView.delegate = self;
    userCommentTableView.dataSource = self;
    
    [self.view addSubview:userCommentTableView];
    userCommentTableView.hidden = YES;
    
}
#pragma mark 视频介绍按钮触发事件
- (IBAction)videoIntroduceButtonPresseed:(id)sender
{
    [_videoIntroduceButton setBackgroundImage:[UIImage imageNamed:@"videoDetailIntrocude.png"] forState:UIControlStateNormal];
    [_relatedVideoButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_userCommentButton setBackgroundImage:nil forState:UIControlStateNormal];
    relatedVideoTableView.hidden = YES;
    commentTotal.hidden = YES;
    userCommentTableView.hidden = YES;
    videoIntroduceTextView.hidden = NO;
    //[self loadVideoDetail];
}


#pragma mark 相关视频按钮触发事件
- (IBAction)relatedVideoButtonPressed:(id)sender
{
    [_videoIntroduceButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_relatedVideoButton setBackgroundImage:[UIImage imageNamed:@"videoDetailAboutVideo.png"] forState:UIControlStateNormal];
    [_userCommentButton setBackgroundImage:nil forState:UIControlStateNormal];
    videoIntroduceTextView.hidden = YES;
    userCommentTableView.hidden = YES;
    commentTotal.hidden = YES;
    relatedVideoTableView.hidden = NO;
    [self loadRelatedVideoList];
}

-(void)loadRelatedVideoList
{
    NSString *videoCategoryId = [_videoDetailDic objectForKey:@"category_id"];
    NSDictionary *dict = [[NSDictionary alloc]init];
    //limit 每页最大条数，默认15
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"vid":self.videoGuid,
             @"cid":videoCategoryId,
             @"limit":@"15"};
    [[VideoClient instance]getRelatedVideoListOnVideoDetail:dict success:^(id sender) {
        [self loadRelatedVideoTableVide:sender];
    } failure:^(id sender) {
        
    }];
}
-(void)loadRelatedVideoTableVide:(id)sender
{
    self.relatedVideoArray = [[sender objectForKey:@"datas"] objectForKey:@"lists"];
    [relatedVideoTableView reloadData];
}
#pragma mark 用户评论按钮触发事件
- (IBAction)userCommentButtonPressed:(id)sender
{
    [_videoIntroduceButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_relatedVideoButton setBackgroundImage:nil forState:UIControlStateNormal];
    [_userCommentButton setBackgroundImage:[UIImage imageNamed:@"videoDetailUserComment.png"]  forState:UIControlStateNormal];
    relatedVideoTableView.hidden = YES;
    videoIntroduceTextView.hidden = YES;
    userCommentTableView.hidden = NO;
    commentTotal.hidden = NO;
    [self loadUserCommentList];
    
   
}

#pragma mark 键盘上的输入框
-(void)layoutKeyBoard
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, rect.size.height +23,rect.size.width,45)];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
//  UIEdgeInsets insets = UIEdgeInsetsMake(40, 0, 40, 0);
//    [toolBar setBackgroundImage:[[UIImage imageNamed:@"keyBoardBack"] resizableImageWithCapInsets:insets] forToolbarPosition:0 barMetrics:0];
//    [toolBar setBarStyle:UIBarStyleBlack];
    [self.view addSubview:toolBar];
    
    //可以自适应高度的文本输入框
    textView = [[UIExpandingTextView alloc] initWithFrame:CGRectMake(70, 5, 180, 36)];
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(4.0f, 0.0f, 10.0f, 0.0f);
    [textView.internalTextView setReturnKeyType:UIReturnKeyDefault];
    textView.delegate = self;
    textView.maximumNumberOfLines=5;
    [toolBar addSubview:textView];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(senderButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    sendButton.frame = CGRectMake(toolBar.bounds.size.width - 68.0f,
                                  6.0f,
                                  58.0f,
                                  29.0f);
    [toolBar addSubview:sendButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(8.0f,
                                    6.0f,
                                    58.0f,
                                    29.0f);
    [toolBar addSubview:cancelButton];
    
    
    __block VideoDetailViewController *videClass = self;
    self.view.keyboardTriggerOffset = toolBar.bounds.size.height;
    
    [videClass.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
        /*
         Try not to call "self" inside this block (retain cycle).
         But if you do, make sure to remove DAKeyboardControl
         when you are done with the view controller by calling:
         [self.view removeKeyboardControl];
         */
        
        CGRect toolBarFrame = toolBar.frame;
        toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
        toolBar.frame = toolBarFrame;
        if (i == 2)
        {
            CGRect toolBarFrame = toolBar.frame;
            toolBarFrame.origin.y = keyboardFrameInView.origin.y ;
            toolBar.frame = toolBarFrame;
        }
    }];
}
#pragma mark -
#pragma mark UIExpandingTextView delegate
//改变toolbar高度
-(void)expandingTextView:(UIExpandingTextView *)expandingTextView willChangeHeight:(float)height
{
    /* Adjust the height of the toolbar when the input component expands */
    float diff = (textView.frame.size.height - height);
    CGRect r = toolBar.frame;
    r.origin.y += diff;
    r.size.height -= diff;
    toolBar.frame = r;
}

#pragma mark 键盘上输入框发送按钮触发事件
-(void)senderButtonPressed
{
    if (textView.text.length == 0)
    {
        [self.view makeToast:@"评论内容不能为空" duration:2.0 position:@"top"];
    }
    else
    {
        i = 2;
        self.str = textView.text;
        NSLog(@"send textView = %@----str = %@，length = %d",textView.text,self.str,textView.text.length );
        [textView resignFirstResponder];
        //[textField removeFromSuperview];
        NSDictionary *dict = [[NSDictionary alloc]init];
        //limit 每页最大条数，默认15
        dict = @{@"appkey":[md5Change md5:APPKEY],
                 @"video_guid":self.videoGuid,
                 @"user_id":[NSNumber numberWithInt:userInfoID],
                 @"comment":textView.text};
        NSLog(@"dict = =%@",dict);
        [[VideoClient instance]sendUserComment:dict success:^(id sender) {
            NSInteger ret = [[sender objectForKey:@"ret"] intValue];
            NSLog(@"----ret = %d,====sender = %@",ret,sender);
            
            if (ret == 1)
            {
                [self.view makeToast:@" 1个经验值"
                            duration:3.0
                            position:@"center"
                               image:[UIImage imageNamed:@"addIcon.png"]];
                [self userCommentButtonPressed:nil];
            }
            else
            {
                [self.view makeToast:@"评论失败" duration:3.0 position:@"center"];
            }
            
        } failure:^(id sender) {
            
        }];
    }
    

    
}

#pragma mark 键盘上取消框发送触发事件
-(void)cancelButtonPressed
{
    i = 2;
    [textView resignFirstResponder];
}
#pragma mark 获取视频评论列表
-(void)loadUserCommentList
{
    NSDictionary *dict = [[NSDictionary alloc]init];
    //limit 每页最大条数，默认15
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"vid":self.videoGuid,
             @"page":@"1",
             @"limit":@"15"};
    [[VideoClient instance]getUserCommentList1:dict success:^(id sender) {
        [self loadUserCommentArray:sender];
    } failure:^(id sender) {
        
    }];
}
-(void)loadUserCommentArray:(id)sender
{
    self.userCommentArray = [[sender objectForKey:@"datas"] objectForKey:@"lists"];
    self.commentCount = [[[sender objectForKey:@"datas"] objectForKey:@"count"] intValue];
    
    commentTotal.text = [NSString stringWithFormat:@"   评论（%d）",self.commentCount];
    [userCommentTableView reloadData];
}
#if 1
#pragma mark 列表委托方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == relatedVideoTableView) {
        static NSString *searchResultListTableIdentifier = @"baseCellIdentifier";
        BaseCell *cell = (BaseCell *)[tableView dequeueReusableCellWithIdentifier:searchResultListTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BaseCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.mTitle.text = [[_relatedVideoArray objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.mIntroduce.text = [[_relatedVideoArray objectAtIndex:indexPath.row] objectForKey:@"brief"];
        cell.mPlayCount.text = [[[_relatedVideoArray objectAtIndex:indexPath.row] objectForKey:@"play_count"] stringValue];
        NSURL *imgUrl = [NSURL URLWithString:[[_relatedVideoArray objectAtIndex:indexPath.row] objectForKey:@"imgurl"]];
        [cell.mThumbnail setImageWithURL:imgUrl];
         return cell;
    }else
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithFrame:CGRectZero];     
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.tag = 1;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:17];
            label.lineBreakMode = UILineBreakModeCharacterWrap;
            label.highlightedTextColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            label.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
            label.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:label];
            //评论人
            UILabel *commentUserLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 70, 20)];
            commentUserLabel.tag = 2;
            commentUserLabel.backgroundColor = [UIColor clearColor];
            commentUserLabel.font = [UIFont systemFontOfSize:14];
            commentUserLabel.textColor = [UIColor blueColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:commentUserLabel];
            
            //评论时间
            UILabel *commentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 100, 15)];
            commentTimeLabel.tag = 3;
            commentTimeLabel.backgroundColor = [UIColor clearColor];
            commentTimeLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:commentTimeLabel];
            
            //用户等级
            UIImageView *levelImageView = [[UIImageView alloc]init];
            levelImageView.frame = CGRectMake(80, 8, 31, 13);
            levelImageView.tag = 4;
            [cell.contentView addSubview:levelImageView];
        }
        //评论内容赋值
        UILabel *Commentlabel = (UILabel *)[cell viewWithTag:1];
        CGRect cellFrame = [cell frame];
        cellFrame.origin = CGPointMake(10, 30);
        
        Commentlabel.text = [[self.userCommentArray objectAtIndex:indexPath.row] objectForKey:@"comment"];

        CGRect rect = CGRectInset(cellFrame, 1, 2);
        Commentlabel.frame = rect;
        [Commentlabel sizeToFit];
        if (Commentlabel.frame.size.height > 46) {
            cellFrame.size.height = 50 + Commentlabel.frame.size.height - 46+15+35;
        }
        else {
            cellFrame.size.height = 50+35;
        }
        [cell setFrame:cellFrame];
        //评论人赋值
        UILabel *Countlabel = (UILabel *)[cell viewWithTag:2];
  
        Countlabel.text = [[self.userCommentArray objectAtIndex:indexPath.row] objectForKey:@"user_name"];

        //评论时间赋值
        UILabel *timelabel = (UILabel *)[cell viewWithTag:3];
        NSInteger aa = [[[self.userCommentArray objectAtIndex:indexPath.row] objectForKey:@"ctime"] intValue];
        NSDate *dat = [NSDate dateWithTimeIntervalSince1970:aa];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *strDate = [dateFormatter stringFromDate:dat];
        timelabel.text = strDate;
        
        //用户等级赋值
        UIImageView *levelImage = (UIImageView*)[cell viewWithTag:4];
        NSInteger levelNumber = [[[self.userCommentArray objectAtIndex:indexPath.row] objectForKey:@"user_level"] intValue];
        if (levelNumber == 2)
        {
            levelImage.image = [UIImage imageNamed:@"level2.png"];
        }
        else if (levelNumber == 3)
        {
            levelImage.image = [UIImage imageNamed:@"level3.png"];
        }
        else if (levelNumber == 4)
        {
            levelImage.image = [UIImage imageNamed:@"level4.png"];
        }
        else if (levelNumber == 5)
        {
            levelImage.image = [UIImage imageNamed:@"level5.png"];
        }
        else if (levelNumber == 6)
        {
            levelImage.image = [UIImage imageNamed:@"level6.png"];
        }
        else if (levelNumber == 7)
        {
            levelImage.image = [UIImage imageNamed:@"level7.png"];
        }
        else if (levelNumber == 8)
        {
            levelImage.image = [UIImage imageNamed:@"level8.png"];
        }
        else if (levelNumber == 9)
        {
            levelImage.image = [UIImage imageNamed:@"level9.png"];
        }
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == relatedVideoTableView)
    {
        return 113;
    }else{
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == relatedVideoTableView) {
        return [_relatedVideoArray count];
    }else //(tableView == self.userCommentTableView)
        return [self.userCommentArray count];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == relatedVideoTableView)
    {
        //需求为跳入相关视频详情页，这样会造成推进的层次太多， 后期咨询 是否考虑改为在本页面刷新
        NSString *guid = [[_relatedVideoArray objectAtIndex:indexPath.row] objectForKey:@"guid"];
        VideoDetailViewController *detail = [[VideoDetailViewController alloc]initWithVideoID:guid];
        [self.navigationController pushViewController:detail animated:YES];
    }
    else{
        ;
    }

}
#endif







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setVideoDetailImage:nil];
    [self setVideoDetailNameLabel:nil];
    [self setVideoBuyCountLabel:nil];
    [self setVideoLikeCount:nil];
    [self setVideoPlayNowButton:nil];
    [self setVideoIntroduceButton:nil];
    [self setRelatedVideoButton:nil];
    [self setUserCommentButton:nil];
    [super viewDidUnload];
}
@end
