//
//  MemberIntroduceViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-6-5.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "MemberIntroduceViewController.h"
#import "ALTabBarController.h"
@interface MemberIntroduceViewController ()

@end

@implementation MemberIntroduceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"会员说明";
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideTabBar];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layOutMemberView];
	// Do any additional setup after loading the view.
}
-(void)layOutMemberView
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 22, 120, 105)];
    imgView.image  = [UIImage imageNamed:@"memberIntroImage.png"];
    [self.view addSubview:imgView];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buyTaoz:(id)sender {
}
@end
