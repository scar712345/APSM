//
//  yumeRCPRemoteControllerParameter.h
//  BT_Central
//
//  Created by APP559 on 2014/4/29.
//  Copyright (c) 2014年 Yume. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface yumeRCPRemoteControllerRadio : NSObject
@property (nonatomic) short valueMCU;
@property (nonatomic,readonly) short valueUI;

-(id)initWithMin:(short)min WithMax:(short)max WithZoom:(short)zoom WithOffset:(short)offset;

@end
