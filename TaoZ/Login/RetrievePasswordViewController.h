//
//  RetrievePasswordViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-5-20.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetrievePasswordViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *mUserNumber;
@property (strong, nonatomic) IBOutlet UITextField *mVfCode;
@property (strong, nonatomic) IBOutlet UITextField *mNewPassword;

@property (strong, nonatomic) IBOutlet UIButton *mSendVfCodeButton;
@property (strong, nonatomic) IBOutlet UIButton *mResetPasswordButton;
@property (strong, nonatomic) IBOutlet UILabel *mVfMessage;
@property (strong, nonatomic) IBOutlet UILabel *mResetPasswordMessage;

- (IBAction)sendVfcode:(id)sender;
- (IBAction)reSetPassword:(id)sender;
- (IBAction)backKeyboard:(id)sender;

@end
