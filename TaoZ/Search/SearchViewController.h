//
//  SearchViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-5-22.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface SearchViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    sqlite3 *db;
    UIScrollView       *m_pTypeView;
    UIView *vie;
}

@property (strong, nonatomic) IBOutlet UIButton *hotButtonOne;
@property (strong, nonatomic) IBOutlet UIButton *hotButtonTwo;
@property (strong, nonatomic) IBOutlet UIButton *hotButtonThree;
@property (strong, nonatomic) IBOutlet UIButton *hotButtonFour;
@property (strong, nonatomic) IBOutlet UIButton *hotButtonFive;
@property (strong, nonatomic) IBOutlet UIButton *hotButtonSix;
@property (strong, nonatomic) IBOutlet UIButton *hotButtonClear;
@property (strong, nonatomic) IBOutlet UIButton *historyButtonOne;
@property (strong, nonatomic) IBOutlet UIButton *historyButtonTwo;
@property (strong, nonatomic) IBOutlet UIButton *historyButtonThree;
@property (strong, nonatomic) IBOutlet UIButton *historyButtonFour;
@property (strong, nonatomic) IBOutlet UIButton *historyButtonFive;

- (IBAction)hotSearchButtonPressed:(id)sender;
- (IBAction)clearSearchHistoryButtonPressed:(id)sender;



@end
