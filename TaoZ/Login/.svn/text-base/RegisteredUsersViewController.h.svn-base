//
//  RegisteredUsersViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-5-15.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "md5Change.h"
#import "KeyBoardTopBar.h"
#import "UIKeyboardViewController.h"

@interface RegisteredUsersViewController : UIViewController<UITextFieldDelegate,UIKeyboardViewControllerDelegate>
{
    NSMutableArray *editFieldArray;     //存放视图中可编辑的控件
    KeyBoardTopBar *keyboardbar;
    UIKeyboardViewController *keyBoardController;
}
@property(nonatomic,strong)IBOutlet UITextField *mRegister_number;          //注册号码
@property(nonatomic,strong)IBOutlet UITextField *mRegister_password;        //注册密码
@property(nonatomic,strong)IBOutlet UITextField *mVfCode;                   //验证码
@property(nonatomic,strong)IBOutlet UITextField *mNickName;                 //昵称

@property(nonatomic,strong)IBOutlet UILabel     *mResponseMessage;          //注册提示消息（成功，失败等）


@property(nonatomic,strong)IBOutlet UIButton    *mSendVfCode;
@property(nonatomic,strong)IBOutlet UIButton    *mRegisterButton;



//- (IBAction)TextField_EndOnEditing:(id)sender;                              //按return键收回键盘方法

- (IBAction)SendVfCodeButtonPressed:(id)sender;                             //发送验证码方法

- (IBAction)RegisterButtonPressed:(id)sender;                               //注册按钮触发方法
@end
