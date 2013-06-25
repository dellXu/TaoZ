//
//  VideosCategoryesListViewController.h
//  TaoZ
//
//  Created by xudeliang on 13-6-3.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface VideosCategoryesListViewController : RootViewController
<UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate>
{
    //上拉、下拉刷新相关变量
    NSMutableArray *_dataSource;
    NSInteger _totalNumberOfRows;
    NSInteger _refreshCount;
    NSInteger _loadMoreCount;
    
    NSString *videoCategoryId;
    //pickview相关
    UIActionSheet* pickerSheet;
	bool isPickerShow;
	UIPickerView* picker;
    NSArray* sourceArray;
    
    int leftRitht;//选择的是左边还是右边按钮 1为左边，2为右边
    UIButton *leftBtn;
    UIButton *rihgittBtn;
    
    int selectedNumber;//选择的是第几行 没做选择则默认为0;
    
    NSMutableArray *secTitleAry;//二级菜单列表名称数组
    NSMutableArray * idary;//二级菜单对应数字ID数组
    NSMutableArray      *mVideoCategoryArray;
    NSMutableDictionary *Secdict;//二级分类列表字典
}
@property(nonatomic, retain)UIActionSheet* pickerSheet;
@property(nonatomic, retain)UIPickerView* picker;
@property(nonatomic)bool isPickerShow;
@property(nonatomic, retain) NSArray* sourceArray;
-(id)initWithVideoID:(NSString *)videoCategoryID;
-(void)setLeftButtonArray:(NSMutableArray *)secondTitleAry;
@end
