//
//  RetrievePasswordViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-20.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import "md5Change.h"
#import "SDClient.h"
#import "UIViewController+ErrorUI.h"
@interface RetrievePasswordViewController ()
@property (nonatomic,assign) BOOL IsVfOk;//yes 验证码正确，no 验证码错误
@end

@implementation RetrievePasswordViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMUserNumber:nil];
    [self setMVfCode:nil];
    [self setMNewPassword:nil];
    [self setMSendVfCodeButton:nil];
    [self setMResetPasswordButton:nil];
    [self setMVfMessage:nil];
    [self setMResetPasswordMessage:nil];
    [super viewDidUnload];
}
/***********************************************************************
 * 功能描述：验证手机按钮触发事件
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：type：发送验证码（注册）为reg，找回密码为fw
 ***********************************************************************/
- (IBAction)sendVfcode:(id)sender {
    NSDictionary *dict = [[NSDictionary alloc]init];
    self.mUserNumber.text=@"15618533265";
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"mobile":self.mUserNumber.text,
             @"type":@"fw"};

    
    [[SDClient instance]sendVerificationToMobile:dict success:^(NSDictionary *dic){
        if ([[dic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:1]])
        {
            self.mResetPasswordMessage.text = @"验证码发送成功，请查收";
        }
        //其他 ret
        //.
        //.
        //.
    }failure:^(NSString *error){
        
    }];

}
/***********************************************************************
 * 功能描述：重置密码按钮触发事件
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：type：发送验证码（注册）为reg，找回密码为fw
 ***********************************************************************/
- (IBAction)reSetPassword:(id)sender {
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"mobile":self.mUserNumber.text,
             @"vfcode":self.mVfCode.text,
             @"pw":[md5Change md5:self.mNewPassword.text]};
    [self validate:dict success:^{
        [[SDClient instance] resetPassword:dict success:^(NSDictionary *reSetPwdMessage){
            if ([[reSetPwdMessage objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:1]])
            {
                self.mResetPasswordMessage.text = [reSetPwdMessage objectForKey:@"msg"];
            }
            //其他 ret
            //.
            //.
            //.
        }failure:^(NSString *error){
            NSLog(@"reSetPassword failure = %@",error);
        }];
    }];
}


/***********************************************************************
 * 功能描述：验证找回密码字典填充情况
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：type：发送验证码（注册）为reg，找回密码为fw
 ***********************************************************************/
-(void)validate:(NSDictionary *)params success:(SDBlock)success {
    NSMutableArray * errors = [@[] mutableCopy];
    
    NSString * mobile = [params objectForKey:@"mobile"];
    if (mobile.length == 0) {
        [errors addObject:@"手机号不能为空"];
    }

    NSString * vfCode = [params objectForKey:@"vfcode"];
    
    if (vfCode.length == 0) {
        [errors addObject:@"验证码不能为空"];
    }
    
 
    NSString * pwd = [params objectForKey:@"pw"];
    if (pwd.length == 0) {
        [errors addObject:@"姓名不能为空"];
    }
    
    if (errors.count != 0) {
        [self showErrors:errors];
    } else {
        success();
    }
    
}
- (IBAction)backKeyboard:(id)sender {
}
#pragma mark -
#pragma mark 触摸背景关闭键盘
/***********************************************************************
 * 功能描述： 触摸背景关闭键盘
 * 输入参数：
 * 输出参数：
 * 返 回 值： 空
 * 其它说明：
 ***********************************************************************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.mUserNumber resignFirstResponder];
    [self.mVfCode resignFirstResponder];
    [self.mNewPassword resignFirstResponder];
}

@end
