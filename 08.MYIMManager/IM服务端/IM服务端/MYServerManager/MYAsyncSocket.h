//
//  MYAsyncSocket.h
//  IM服务端
//
//  Created by mayan on 2017/10/26.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "GCDAsyncSocket.h"

@class GCDAsyncSocket;
@interface MYAsyncSocket : NSObject

// 用于心跳包记录时间
@property (nonatomic, strong) NSDate *NewestDate;
@property (nonatomic, strong) GCDAsyncSocket *socket;

@end
