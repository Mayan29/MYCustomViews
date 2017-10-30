//
//  MYClientManager.m
//  IM客户端
//
//  Created by mayan on 2017/10/26.
//  Copyright © 2017年 mayan. All rights reserved.
//
//  这里我们使用的是 CocoaAsyncSocket 开源库

#import "MYClientManager.h"
#import "GCDAsyncSocket.h"

#define kHeartTime 5  // 客户端 5 秒心跳一次


@interface MYClientManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end


@implementation MYClientManager

#pragma mark - Init
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static MYClientManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 创建 socket 对象
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    return self;
}


#pragma mark - 对外的一些接口
- (BOOL)connectToHost:(NSString *)host onPort:(uint16_t)port currentUserId:(long)userId
{
    _currentUserId = userId;
    return [_clientSocket connectToHost:host onPort:port error:nil];  // 错误信息不在这里显示
}

- (void)disconnect
{
    [_clientSocket disconnect];
}

- (void)sendMessage:(NSString *)message
{
    if (message.length == 0) return;
    
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:_currentUserId];
}


#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)clientSocket didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"%@ : 与服务器链接成功", NSStringFromClass(self.class));
    [clientSocket readDataWithTimeout:-1 tag:0];
    
    // 开启个不死线程发送心跳
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @autoreleasepool {
            [NSTimer scheduledTimerWithTimeInterval:kHeartTime target:self selector:@selector(heartBeat) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] run];
        }
    });
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"%@ : 与服务器断开连接 或 链接失败 : %@", NSStringFromClass(self.class), err);
}

// 读取消息
- (void)socket:(GCDAsyncSocket *)clientSocket didReadData:(NSData *)data withTag:(long)tag 
{
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(clientManager:didReadMsg:userId:)]) {
            [self.delegate clientManager:self didReadMsg:str userId:tag];
        }
    });
    
    [clientSocket readDataWithTimeout:-1 tag:0];
}


#pragma mark - 心跳包
- (void)heartBeat
{
    [self sendMessage:@"heart"];
}

@end
