//
//  UIViewController+ErrorUI.m
//  shangdao
//
//  Created by Yang Yi on 3/20/13.
//  Copyright (c) 2013 yunbang. All rights reserved.
//

#import "UIViewController+ErrorUI.h"

@implementation UIViewController (ErrorUI)

-(void)showErrors:(NSArray *)errors {
    NSMutableString * message = [[NSMutableString alloc] init];
    
    [errors each:^(NSString * error) {
        [message appendFormat:@"%@\n", error];
    }];
    
    [UIAlertView showAlertViewWithTitle:@""
                                message:message
                      cancelButtonTitle:@"确定"
                      otherButtonTitles:nil
                                handler:nil];
}

@end
