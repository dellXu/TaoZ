//
//  MyTaoZhuViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-6-9.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "MyTaoZhuViewController.h"
#import "LoginViewController.h"
#import "ALTabBarController.h"
#import "MemberIntroduceViewController.h"
#import "SuggestionFeedBackViewController.h"
#import "MainClient.h"
#import "MyAccountViewController.h"
#import "getUserInfo.h"
@interface MyTaoZhuViewController ()

@end

@implementation MyTaoZhuViewController
@synthesize loginBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization  
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideExistingTabBar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我的陶朱";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyCount:nil];
    [self setLevelBtn:nil];
    [self setOnlyWifiBtn:nil];
    [self setSoftDeclare:nil];
    [self setTeamIntrduceBtn:nil];
    [self setSuggestBtn:nil];
    [self setShareBtn:nil];
    [self setUpdateOnliteBtn:nil];
    [self setWifiOnly:nil];
    [super viewDidUnload];
}
- (IBAction)loginBtnPressed:(id)sender {
    NSLog(@"loginBtnPressed");
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"myTaoCellTouchBg"] forState:UIControlStateHighlighted];
//    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MyTaozViewController1" bundle:nil];
//    
//    UIViewController * loginView           = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    LoginViewController *loginView = [[LoginViewController alloc] init];
    [loginView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:loginView animated:NO];
    
}

- (IBAction)levelBtnPressed:(id)sender {
    NSLog(@"levelBtnPressed");
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"myTaoCellTouchBg"] forState:UIControlStateHighlighted];
    MemberIntroduceViewController *mem = [[MemberIntroduceViewController alloc] init];
    [mem setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:mem animated:YES];
}

- (IBAction)softDeclareBtnPressed:(id)sender {
    NSLog(@"softDeclareBtnPressed");
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"myTaoCellTouchBg"] forState:UIControlStateHighlighted];
}

- (IBAction)teamIntrBtnPressed:(id)sender {
    NSLog(@"teamIntrBtnPressed");
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"myTaoCellTouchBg"] forState:UIControlStateHighlighted];
}

- (IBAction)suggestBtnPressed:(id)sender {
    NSLog(@"suggestBtnPressed");
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"myTaoCellTouchBg"] forState:UIControlStateHighlighted];
    
    SuggestionFeedBackViewController *suggest = [[SuggestionFeedBackViewController alloc]init];
    [suggest setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:suggest animated:YES];
}

- (IBAction)shareBtnPressed:(id)sender {
    NSLog(@"shareBtnPressed");
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"myTaoCellTouchBg"] forState:UIControlStateHighlighted];
}

- (IBAction)updateBtnPressed:(id)sender {
    NSLog(@"updateBtnPressed");
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"myTaoCellTouchBg"] forState:UIControlStateHighlighted];
    [[MainClient instance] getVersionUpdate:nil success:^(id sender){
 
    if ([[sender objectForKey:@"ret"] isEqualToNumber:[NSNumber numberWithInt:1]])
    {
        NSDictionary *verInfo = [[NSDictionary alloc]initWithDictionary:[sender objectForKey:@"datas"]];
        NSString *updateInfo = [verInfo objectForKey:@"memo"];
   
        NSString *verNumber = [verInfo objectForKey:@"ver"];
        
        if([verNumber isEqualToString:TAOZ_VERSION])
        {
            [self.view makeToast:@"您使用的已经是最新版本" duration:2.5f position:@"center"];
        }
        else
        {            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新内容"
                                                           message:updateInfo
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
        
    } failure:^(id sender) {
                                        
    }];
    
}

- (IBAction)myCountPressed:(id)sender {
     NSLog(@"myCountPressed");
    UIButton *btn = (UIButton *)sender;
    [btn setBackgroundImage:[UIImage imageNamed:@"myTaoCellTouchBg"] forState:UIControlStateHighlighted];
    //获取用户账号、密码（若不为空则以登录，为空则未登陆）
    getUserInfo *getinfo = [getUserInfo alloc];
    NSArray *userAccountAndPwd = [[NSArray alloc]initWithArray:[getinfo getUserAccountAndPwd]];
    
    if (userAccountAndPwd.count>0)
    {
        MyAccountViewController *myAccountView = [[MyAccountViewController alloc]init];
        [myAccountView passUserAccountAndPwd:userAccountAndPwd];
        [myAccountView setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myAccountView animated:YES];
    }
    else {
        [self.view makeToast:@"登录后才能进入我的帐号，请登陆" duration:3.0f position:@"center"];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        return;
    }
    else if (buttonIndex == 1)
    {
        //拼接APP在appstore的id
        NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",TAOZAPP_ID];
        //跳转至appstore进行更新
        NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
        [[UIApplication sharedApplication] openURL:iTunesURL];
        
    }
}

@end
