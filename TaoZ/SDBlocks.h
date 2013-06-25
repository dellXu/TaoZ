
//  SDBlocks.h
//  shangdao
//
//  Created by Yang Yi on 3/11/13.
//  Copyright (c) 2013 yunbang. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AudioColumn.h"
//#import "Audio.h"
//#import "Expert.h"

typedef void(^SDBlock)();
typedef void(^SDSenderBlock)(id sender);
typedef void(^SDListBlock)(NSArray * list);

//typedef void(^SDAudioColumnBlock)(AudioColumn * column);
//typedef void(^SDAudioBlock)(Audio * audio);
typedef void(^SDProgressBlock)(float progress);

typedef void(^SDHintsBlock)(NSString * keyword, SDListBlock resultsBlock);

//typedef void(^SDExpertBlock)(Expert * expert);
