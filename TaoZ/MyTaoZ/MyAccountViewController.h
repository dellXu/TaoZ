//
//  MyAccountViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-6-18.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    UIDatePicker *datePicker;
    UIToolbar *pickerDateToolBar;
    BOOL isLogin;
    NSArray *accountAndPwdAry;
    NSDictionary *userInfoDic;
}
-(void)passUserAccountAndPwd:(NSArray *)accountAry;//上层界面传递用户账号和密码来
@end
