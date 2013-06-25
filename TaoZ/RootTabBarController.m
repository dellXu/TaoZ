//
//  RootTabBarController.m
//  shangdao
//
//  Created by Yang Yi on 2/25/13.
//  Copyright (c) 2013 yunbang. All rights reserved.
//

#import "RootTabBarController.h"
#import "HomePageViewController.h"
#import "VideosCategoriesViewController.h"
#import "MyTaozViewController.h"
#import "NSArray+BlocksKit.h"
#import "VideoRankingListViewController.h"
@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"MyTaozViewController" bundle:nil];
        
        UIViewController * homePage         = [[HomePageViewController alloc] init];
        UIViewController * videosCategories = [[VideosCategoriesViewController alloc] init];
        UIViewController * videoschars      = [[VideoRankingListViewController alloc] init];
        UIViewController * myTaoz           = [storyboard instantiateViewControllerWithIdentifier:@"MyTaozViewController"];

        NSArray * controllers = @[homePage, videosCategories, videoschars, myTaoz];
        
        //NSArray * controllers = @[myTaoz,homePage, videosCategories, videoCharts];
        self.viewControllers = [controllers map:^(UIViewController * controller) {
            return [[UINavigationController alloc] initWithRootViewController:controller];
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

-(void)viewWillLayoutSubviews {

    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"22"]];
  
    [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"201_.png"]];

    //UIFont * barFont = [UIFont systemFontOfSize:15.0f];
    
    //NSDictionary * textAttributes = @{UITextAttributeFont: barFont};
    int i = 1;
    for (UITabBarItem * item in self.tabBar.items) {
        item.tag = i;
        i++;
        //[item setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, 120)];
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
   // [self.tabBar setBackgroundImage:[UIImage imageNamed:@"toolbar.png"]];

    [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:[NSString stringWithFormat:@"20%d_.png",item.tag]]];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
