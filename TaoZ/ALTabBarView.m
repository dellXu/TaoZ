//
//  ALTabBarView.m
//  ALCommon
//
//  Created by Andrew Little on 10-08-17.
//  Copyright (c) 2010 Little Apps - www.myroles.ca. All rights reserved.
//

#import "ALTabBarView.h"


@implementation ALTabBarView

@synthesize delegate;
@synthesize selectedButton;



- (void)dealloc
{
    [selectedButton release];
    delegate = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        // Initialization code
    }
    return self;
}

//Let the delegate know that a tab has been touched
-(IBAction) touchButton:(id)sender
{
    if( delegate != nil && [delegate respondsToSelector:@selector(tabWasSelected:)])
    {
        if (selectedButton) 
        {
            [selectedButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"0%d.png", selectedButton.tag +1]] forState:UIControlStateNormal];
            [selectedButton release];
        }
        
        selectedButton = [((UIButton *)sender) retain];
        [selectedButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"0%d_.png", selectedButton.tag + 1]] forState:UIControlStateNormal];
        [delegate tabWasSelected:selectedButton.tag];
    }
}

-(void)setSelectedButton:(UIButton *)button
{
    selectedButton = button;
}

@end
