//
//  AppDelegate.m
//  TaoZ
//
//  Created by xudeliang on 13-5-14.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"

#import <TencentOpenAPI/TencentOAuth.h>
@implementation AppDelegate

@synthesize m_window;
@synthesize m_pTabBarCtrl;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if 0
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    RootTabBarController * rootController = [[RootTabBarController alloc] init];
    self.window.rootViewController = rootController;
    [self customizeApperance];
    [self.window makeKeyAndVisible];
#endif
//    CGRect rect = [[UIScreen mainScreen]bounds];
//    m_pHomePageCtrl = (HomePageViewController *)[[HomePageViewController alloc]init];
//    m_pHomePageCtrl.view.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    //[self.m_window insertSubview:m_pHomePageCtrl.view atIndex:1];
    [self customizeApperance];
    
    [self.m_window makeKeyAndVisible];
   // [self.m_window insertSubview:m_pTabBarCtrl.view atIndex:0];
    [self.m_window addSubview:m_pTabBarCtrl.view];
    
    
    return YES;
    
    
    
}
-(void)customizeApperance {
    
    UIImage * navBg = [UIImage imageNamed:@"NavBarBg"];
    
    id navApperance = [UINavigationBar appearance];
    [navApperance setBackgroundImage:navBg forBarMetrics:UIBarMetricsDefault];
    [navApperance setBarStyle:UIBarStyleBlack];
    
    // search bar
  //  [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"search_bg.png"]];
    

    
}
//QQ登录委托方法
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [TencentOAuth HandleOpenURL:url];
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [TencentOAuth HandleOpenURL:url];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
