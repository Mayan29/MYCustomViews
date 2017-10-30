//
//  MYClientManager.h
//  IM客户端
//
//  Created by mayan on 2017/10/26.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MYClientManager;
@protocol MYClientManagerDelegate <NSObject>

// 读取到的消息
- (void)clientManager:(MYClientManager *)manager didReadMsg:(NSString *)msg userId:(long)userId;

@end

@interface MYClientManager : NSObject

@property (nonatomic, weak) id<MYClientManagerDelegate> delegate;
@property (nonatomic, readonly, assign) long currentUserId;

+ (instancetype)shareManager;
- (BOOL)connectToHost:(NSString *)host onPort:(uint16_t)port currentUserId:(long)userId;  // 连接服务端
- (void)disconnect;  // 断开连接
- (void)sendMessage:(NSString *)message;  // 发送消息


@end
