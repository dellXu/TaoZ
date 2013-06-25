//
//  LoginViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-5-15.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
@interface LoginViewController : UIViewController<UITextFieldDelegate,TencentSessionDelegate>
{
    sqlite3 *db;
}
@property(nonatomic,strong)IBOutlet UITextField * mLoginNumberTextField;
@property(nonatomic,strong)IBOutlet UITextField * mLoginPassWordTextField;
@property(nonatomic,strong)IBOutlet UIButton    * mForgetPassWordButton;
@property(nonatomic,strong)IBOutlet UIButton    * mLoginButton;
@property(nonatomic,strong)IBOutlet UIButton    * mLoginBySinaButton;
@property(nonatomic,strong)IBOutlet UIButton    * mLoginByQQButon;

-(IBAction)loginButtonPressed:(id)sender;
-(IBAction)loginBySinaButtonPressed:(id)sender;
-(IBAction)loginByQQButtonPressed:(id)sender;
-(IBAction)forgetButtonPressed:(id)sender;
-(IBAction)TextField_DidEndOnExit:(id)sender;
@end
