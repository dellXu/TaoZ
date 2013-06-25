//
//  BaseCell.h
//  TaoZ
//
//  Created by xudeliang on 13-5-23.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *mThumbnail; //缩略图
@property (strong, nonatomic) IBOutlet UILabel *mTitle;         //视频名称
@property (strong, nonatomic) IBOutlet UILabel *mIntroduce;     //视频介绍
@property (strong, nonatomic) IBOutlet UILabel *mPlayCount;     //播放次数

@end
