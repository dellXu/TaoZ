//
//  SuggestionFeedBackViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-6-17.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"
@interface SuggestionFeedBackViewController : UIViewController
<UITextViewDelegate,UITextFieldDelegate>
{
    BOOL      isLogin;                  //是否已登录
    NSString  *userInfoGUID;             //用户的guid
}
@property (retain, nonatomic) IBOutlet GCPlaceholderTextView *suggestInput;

@property (strong, nonatomic) IBOutlet UITextField *contactWay;
@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
- (IBAction)ButtonSelected:(id)sender;
- (IBAction)endEdit:(id)sender;

@end
