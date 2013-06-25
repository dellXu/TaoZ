//
//  ALTabBarController.m
//  ALCommon
//
//  Created by Andrew Little on 10-08-17.
//  Copyright (c) 2010 Little Apps - www.myroles.ca. All rights reserved.
//

#import "ALTabBarController.h"
#import "ALTabBarView.h"


@implementation ALTabBarController

@synthesize customTabBarView;
BOOL Mark = NO;
- (void)dealloc 
{
    [customTabBarView release];
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
    if (Mark == NO)
    {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"TabBarView" owner:self options:nil];
        self.customTabBarView = [nibObjects objectAtIndex:0];
        self.customTabBarView.delegate = self;
        for (id sender in [customTabBarView subviews]) 
        {
            if ([sender isKindOfClass:[UIButton class]])
            {
                UIButton *tempButton = (UIButton *)sender;
                if (tempButton.tag == 0)
                {
                    [customTabBarView setSelectedButton:tempButton];
                }
            }
        }
        CGRect rect = [[UIScreen mainScreen]bounds];
        [customTabBarView setFrame:CGRectMake(0, rect.size.height-50, rect.size.width, 50)];
        //[self.view insertSubview:self.customTabBarView atIndex:1];
        [self.view addSubview:customTabBarView];
        Mark = YES;
        
    }
    [self hidenAllView];
}

- (void)hideTabBar
{
    [self.customTabBarView setHidden:YES];
    //隐藏系统tabbar
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

- (void)hideExistingTabBar
{
    [self.customTabBarView setHidden:NO];
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

-(void)hidenAllView
{
//    [self.customTabBarView setHidden:NO];
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}


#pragma mark ALTabBarDelegate

-(void)tabWasSelected:(NSInteger)index 
{
    self.selectedIndex = index;
}


@end
