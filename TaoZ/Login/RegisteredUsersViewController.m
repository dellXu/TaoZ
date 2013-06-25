//
//  RegisteredUsersViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-15.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "RegisteredUsersViewController.h"
#import "SDClient.h"
#import "JSONKit.h"
#import "UIViewController+ErrorUI.h"
@interface RegisteredUsersViewController ()
@property (nonatomic,readonly) NSString *md5Code;
@end

@implementation RegisteredUsersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layOutView];
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    
   // _md5Code = [self md5:@"taozapp2013"];
//    keyboardbar = [[KeyBoardTopBar alloc]init];
//    [keyboardbar  setAllowShowPreAndNext:YES];
//    [keyboardbar setIsInNavigationController:YES];
//    [keyboardbar setTextFieldsArray:editFieldArray];
//    [self.view addSubview:keyboardbar.view];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)layOutView
{
    self.navigationItem.title = @"注册";
    UIImageView *mRegister_numberImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"textFieldLeft.png"]];
    self.mRegister_number.leftView = mRegister_numberImage;
    self.mRegister_number.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *mRegister_passwordImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"textFieldLeft.png"]];
    self.mRegister_password.leftView = mRegister_passwordImage;
    self.mRegister_password.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *mVfCodeImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"textFieldLeft.png"]];
    self.mVfCode.leftView = mVfCodeImage;
    self.mVfCode.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *mNickNameImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"textFieldLeft.png"]];
    self.mNickName.leftView = mNickNameImage;
    self.mNickName.leftViewMode = UITextFieldViewModeAlways;
    
}

/***********************************************************************
 * 功能描述：发送注册请求（按下注册按钮）
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)didTapSignupButton
{
    
    NSDictionary * dict = [self formParams];
    
    
    [self validate:dict success:^{
        SDClient *sdClient = [SDClient instance];
        
        [sdClient signupWithParams:dict success:^(NSDictionary * dic) {
            
            NSLog(@"signup dictionary = %@",[dic objectForKey:@"ret"]);
            self.mResponseMessage.text = [dic objectForKey:@"msg"];
        } failure:^(NSString * error) {
            NSLog(@"--errot = -%@",error);
        }];

    }];
    
    
    
}


/***********************************************************************
 * 功能描述：注册按钮触发事件
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
- (IBAction)RegisterButtonPressed:(id)sender
{
    [self didTapSignupButton];
}


/***********************************************************************
 * 功能描述：构建注册信息字典
 * 输入参数：
 * 输出参数：
 * 返 回 值：注册信息字典
 * 其它说明：user_type=1 用户类型默认为普通用户
 ***********************************************************************/
-(NSDictionary *)formParams
{
    NSDictionary *dict = [[NSDictionary alloc] init];

    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"accaunt":self.mRegister_number.text,
             @"pw":[md5Change md5:self.mRegister_password.text],
             @"user_type":@"1",
             @"lastname":self.mNickName.text,
             @"vfcode":self.mVfCode.text};
    return dict;
}


/***********************************************************************
 * 功能描述：验证注册信息
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
-(void)validate:(NSDictionary *)params success:(SDBlock)success {
    NSMutableArray * errors = [@[] mutableCopy];
    
    NSString * mobile = [params objectForKey:@"accaunt"];
    if (mobile.length == 0) {
        [errors addObject:@"手机号不能为空"];
    }
    
    NSString * vfCode = [params objectForKey:@"vfcode"];
    
    if (vfCode.length == 0) {
        [errors addObject:@"验证码不能为空"];
    }
    
    
    NSString * pwd = [params objectForKey:@"pw"];
    if (pwd.length == 0) {
        [errors addObject:@"密码不能为空"];
    }
    
    
    NSString * lastname = [params objectForKey:@"lastname"];
    if (lastname.length == 0) {
        [errors addObject:@"姓名不能为空"];
    }
    
    if (errors.count != 0) {
        [self showErrors:errors];
    } else {
        success();
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/***********************************************************************
 * 功能描述：return 收回键盘
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：
 ***********************************************************************/
//- (IBAction)TextField_EndOnEditing:(id)sender
//{
//    NSLog(@"---------11--");
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   // [keyboardbar showBar:textField]; //KeyBoardTopBar的实例对象调用显示键盘方法
}
/***********************************************************************
 * 功能描述：验证手机按钮触发事件(注册)
 * 输入参数：
 * 输出参数：
 * 返 回 值：
 * 其它说明：type：发送验证码（注册）为reg，找回密码为fw
 ***********************************************************************/
- (IBAction)SendVfCodeButtonPressed:(id)sender
{
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"appkey":[md5Change md5:APPKEY],
             @"mobile":self.mRegister_number.text,
             @"type":@"reg"};

    [[SDClient instance] sendVerificationToMobile:dict success:^(NSDictionary *reDic){
        //验证码发送成功
        if([[reDic objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:1]] )
        {
            NSLog(@"验证码发送成功，请注意查收");
            [self.view makeToast:@"验证码发送成功，请注意查收" duration:3.0 position:@"center"];
            
        }else{
            [self.view makeToast:@"验证码发送失败" duration:3.0 position:@"center"];
        }
        
    }failure:^(id sender){
        @throw sender;
        
    }];
  
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
	[self.mRegister_number resignFirstResponder];
    [self.mRegister_password resignFirstResponder];
    [self.mNickName resignFirstResponder];
    [self.mVfCode resignFirstResponder];
}


@end
