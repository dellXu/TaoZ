//
//  HomePageViewController.m
//  TaoZ
//
//  Created by xudeliang on 13-5-14.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "HomePageViewController.h"
#import "MyTestViewController.h"
#import "SearchViewController.h"
#import "ALTabBarController.h"
#import "UIViewController+HideTabBar.h"
#import "testViewController.h"
@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    ALTabBarController *tab = (ALTabBarController *)self.tabBarController;
    [tab hideExistingTabBar];
    //[self showTabBar:self.tabBarController];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

  
    
     NSLog(@"---home viewWillAppear self.view -%f",self.view.bounds.size.height);
    self.navigationItem.title = @"首页";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(toabcdeView) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    
    [self layoutSearchButton];
	// Do any additional setup after loading the view.
    

//    toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
//    toolBar.frame = toolBarFrame;

}
-(void)toabcdeView
{
    testViewController *lllll = [[testViewController alloc]init];
    [lllll setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:lllll animated:YES];
    
//    [self.view makeToast:@"收藏成功"];
    
   
   
//    [self.view makeToast:@"评论失败" duration:3.0 position:@"center"];
//    [self.view makeToast:@"收藏成功"
//                duration:3.0
//                position:@"center"
//                   image:[UIImage imageNamed:@"addIcon.png"]];
//    MyTestViewController *lllll = [[MyTestViewController alloc]init];
//    [self.navigationController pushViewController:lllll animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)layoutSearchButton
{
    /* 设置右上角为搜索系统搜索按钮 */

   UIBarButtonItem *searchBarButtonItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch handler:^(id sender) {
       [self toSearchView];
    }];
   
    self.navigationItem.rightBarButtonItem = searchBarButtonItem;
}
-(void)toSearchView
{
    SearchViewController *searchView = [[SearchViewController alloc]init];
    [searchView setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:searchView animated:YES];
}
-(void)searchButtonPress
{
    
}

@end
