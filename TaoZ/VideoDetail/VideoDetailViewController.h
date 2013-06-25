//
//  VideoDetailViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-5-28.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIExpandingTextView.h"
@interface VideoDetailViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIExpandingTextViewDelegate>
{
    UITextView *videoIntroduceTextView;//视频介绍
    UIImageView *opearImageView;        //底部视图
    UITableView *relatedVideoTableView;//视频介绍tableView
    UITableView *userCommentTableView; //用户评论tableView
    UILabel *commentTotal;             //评论总数
    UIButton *likeBtn;                 //收藏按钮
    sqlite3 *db;
    
    NSInteger userInfoIsVip;            //是不是会员
    NSString *userInfoGUID;             //用户的guid
    NSInteger userInfoID;               //用户id
    NSInteger userMoney;                //用户可观看视频条数
    BOOL      isLogin;                  //是否已登录
    
    UIExpandingTextView *textView;//文本输入框
    UIToolbar *toolBar;
    int i ;
}
@property (strong, nonatomic) IBOutlet UIImageView *videoDetailImage;
@property (strong, nonatomic) IBOutlet UILabel *videoDetailNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *videoBuyCountLabel;//播放次数
@property (strong, nonatomic) IBOutlet UILabel *videoLikeCount;
@property (strong, nonatomic) IBOutlet UIButton *videoPlayNowButton;//播放按钮
@property (strong, nonatomic) IBOutlet UIButton *videoIntroduceButton;
@property (strong, nonatomic) IBOutlet UIButton *relatedVideoButton;
@property (strong, nonatomic) IBOutlet UIButton *userCommentButton;

- (IBAction)videoIntroduceButtonPresseed:(id)sender;

- (IBAction)relatedVideoButtonPressed:(id)sender;
- (IBAction)userCommentButtonPressed:(id)sender;
-(id)initWithVideoID:(NSString *)videoGUID;

@end
