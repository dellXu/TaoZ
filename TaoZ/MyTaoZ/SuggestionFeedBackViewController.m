//
//  SuggestionFeedBackViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-6-17.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "SuggestionFeedBackViewController.h"
#import "md5Change.h"
#import "MainClient.h"
#import "getUserInfo.h"
@interface SuggestionFeedBackViewController ()

@end

@implementation SuggestionFeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getUserAllInfo];
    [self layOutSuggestionView];
    // Do any additional setup after loading the view from its nib.
}
-(void)layOutSuggestionView
{
    self.suggestInput.delegate = self;
    self.suggestInput.placeholder = @"感谢您提供使用过程中的宝贵意见，我们会努力改进，为您创造更好的体验！";
    /* 设置右上角为发送按钮 */
	UIButton *pSendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 28)];
    [pSendButton setTitle:@"发送" forState:UIControlStateNormal];
    pSendButton.titleLabel.font= [UIFont systemFontOfSize:14];
	pSendButton.backgroundColor = [UIColor clearColor];
	[pSendButton setBackgroundImage:[UIImage imageNamed:@"register1.png"] forState:UIControlStateNormal];
    [pSendButton setBackgroundImage:[UIImage imageNamed:@"register2.png"] forState:UIControlStateHighlighted];
	[pSendButton addTarget:self
                    action:@selector(pSendButtonPress)
          forControlEvents:UIControlEventTouchUpInside];
	
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:pSendButton];
    self.navigationItem.rightBarButtonItem = searchBarButtonItem;
}
-(void)pSendButtonPress
{
    [self isBtnSelected];
    [self.suggestInput resignFirstResponder];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //若按下的是return 则收起键盘
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES; 

}
//勾选的反馈意见
-(void)isBtnSelected
{
    NSMutableString *muString = [[NSMutableString alloc]init];

    if (self.button1.selected)
    {
        [muString appendString:@"经常崩溃｜"];
    }
    if (self.button2.selected)
    {
        [muString appendString:@"看视频卡｜"];
    }
    if (self.button3.selected)
    {
        [muString appendString:@"视频无法播放｜"];
    }
    if (self.button4.selected)
    {
        [muString appendString:@"无法支付｜"];
    }
    NSString *str = nil;
    if (muString.length>0)//截去最后一个｜
    {
        str = [NSString stringWithString:muString];
        str = [str substringToIndex:muString.length-1];
    }
      
    NSString *suggestionInfo = self.suggestInput.text;
    NSString *suggestPeople = self.contactWay.text;
    if ((str == nil||[str isEqualToString:@""]) && (suggestionInfo == nil||[suggestionInfo isEqualToString:@""]))
    {
        [UIAlertView showAlertViewWithTitle:@"反馈意见、反馈选项不能全为空"
                                    message:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil
                                    handler:nil];
    }
    else
    {
        NSDictionary *dict = [[NSDictionary alloc]init];
        dict = @{@"appkey":[md5Change md5:APPKEY],
                 @"user_guid":(([userInfoGUID isEqualToString:@""])||(userInfoGUID == nil))?@"":userInfoGUID,
                 @"contact":suggestPeople,
                 @"option":str,
                 @"content":suggestionInfo};
        
        [[MainClient instance]appSuggestionFeedBack:dict success:^(NSDictionary *reDict){
            if ([[reDict objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                NSLog(@"user info = %@ ",[dict objectForKey:@"userinfo"]);
                [UIAlertView showAlertViewWithTitle:@"发表成功"
                                            message:@"提交成功啦！十分感谢您的意见，我们一定会及时处理。"
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil
                                            handler:nil];
            }
            else
            {
                [UIAlertView showAlertViewWithTitle:@"发表失败"
                                            message:@"请稍后重试。"
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil
                                            handler:nil];
            }
        }failure:^(id sender) {
            
        }];
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
        isLogin = YES;  //0否  1是
        userInfoGUID = [userinfoDic objectForKey:@"guid"];
        NSLog(@"~~~~~~userinfoDic ~~~ = %@",userinfoDic);
    }
    else {
        isLogin = NO;
    }
    
}

- (IBAction)ButtonSelected:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"feedback2.png"] forState:UIControlStateSelected];
     btn.selected = !btn.selected;
}
//return收回键盘
- (IBAction)endEdit:(id)sender {
    [self.contactWay resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];
    [self setContactWay:nil];
    [self setSuggestInput:nil];
    [super viewDidUnload];
}

@end
