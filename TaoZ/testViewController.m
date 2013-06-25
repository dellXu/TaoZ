//
//  testViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-14.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "testViewController.h"
#import "ALTabBarController.h"
@interface testViewController ()

@end

@implementation testViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //111111111
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    ALTabBarController *tap = (ALTabBarController *)self.tabBarController;
    [tap hideTabBar];
        UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 320, 800)];
        vie.backgroundColor = [UIColor redColor];
        [self.view addSubview:vie];
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

@end
