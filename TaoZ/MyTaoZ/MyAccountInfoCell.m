//
//  MyAccountInfoCell.m
//  TaoZ
//
//  Created by xudeliang on 13-6-20.
//  Copyright (c) 2013年 陶朱网络. All rights reserved.
//

#import "MyAccountInfoCell.h"

@implementation MyAccountInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
