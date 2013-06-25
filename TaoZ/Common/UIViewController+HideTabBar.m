//
//  UIViewController+HideTabBar.m
//  shangdao
//
//  Created by Yang Yi on 3/29/13.
//  Copyright (c) 2013 yunbang. All rights reserved.
//

#import "UIViewController+HideTabBar.h"

@implementation UIViewController (HideTabBar)

- (void)hideTabBar:(UITabBarController *) tabbarcontroller
{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, height, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height)];
        }
    }
    
//    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *) tabbarcontroller
{
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];

    CGFloat height = [UIScreen mainScreen].bounds.size.height - 49-20;

    for(UIView *view in tabbarcontroller.view.subviews)
    {
        
        if([view isKindOfClass:[UITabBar class]])
        {
//            [view setFrame:CGRectMake(view.frame.origin.x, height, view.frame.size.width, view.frame.size.height)];
            [view setFrame:CGRectMake(view.frame.origin.x, height, view.frame.size.width, 50)];
        }
        else
        {
//            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height)];
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 50)];
        }
    }
    
//    [UIView commitAnimations];
}

@end
