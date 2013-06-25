//
//  SearchResultListViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-5-23.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface SearchResultListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UIImageView *infoImage;
    UILabel *infoLabel;
    sqlite3 *db;
}

@property (strong, nonatomic) IBOutlet UISearchBar *mSearchBar;
@property (strong, nonatomic) IBOutlet UITableView *searchResultTableView;

- (void)getSearchKeyWord:(NSString *)searchKeyWord;
@end
