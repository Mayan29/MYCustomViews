//
//  MYServerManager.m
//  MYServer
//
//  Created by mayan on 2017/10/25.
//  Copyright © 2017年 mayan. All rights reserved.
//
//  这里我们使用的是 CocoaAsyncSocket 开源库

#import "MYServerManager.h"
#import "GCDAsyncSocket.h"
#import "MYAsyncSocket.h"

#define kHeartTime 5  // 客户端 5 秒心跳一次


@interface MYServerManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *serverSocket;
@property (nonatomic, strong) NSMutableArray<MYAsyncSocket *> *clientSockets;

@end


@implementation MYServerManager

#pragma mark - Init
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    static MYServerManager *manager = nil;
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
        _serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    }
    return self;
}


#pragma mark - 对外的一些接口
- (BOOL)openServerWithPort:(uint16_t)port
{
    // 绑定端口 & 监听
    NSError *error = nil;
    BOOL isSuccess = [_serverSocket acceptOnPort:port error:&error];
    
    if (!error) {
        NSLog(@"%@ : 服务开启成功", NSStringFromClass(self.class));
        
        // 开启个不死线程不断检测所连接的每个客户端的心跳
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            @autoreleasepool {
                [NSTimer scheduledTimerWithTimeInterval:(kHeartTime * 2) target:self selector:@selector(repeatCheckClineOnline) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] run];
            }
        });
    } else {
        NSLog(@"%@ : 服务开启失败 %@", NSStringFromClass(self.class), error);
    }
    return isSuccess;
}


#pragma mark - Lazy load
- (NSMutableArray *)clientSockets
{
    if (!_clientSockets) {
        _clientSockets = [NSMutableArray array];
    }
    return _clientSockets;
}


#pragma mark - GCDAsyncSocketDelegate
// 当有客户端的 socket 连接到服务器时
- (void)socket:(GCDAsyncSocket *)serverSocket didAcceptNewSocket:(GCDAsyncSocket *)clientSocket
{
    // 1.保存客户端的 socket
    MYAsyncSocket *socket = [[MYAsyncSocket alloc] init];
    socket.socket     = clientSocket;
    socket.NewestDate = [NSDate date];
    [self.clientSockets addObject:socket];
    
    // 2.监听客户端的 clientSocket 有没有数据上传到服务器的 clientSocket，接收到数据调用“读取客户端请求数据”代理
    [clientSocket readDataWithTimeout:-1 tag:0];
    
    NSLog(@"当前有 %ld 客户已经连接到服务器", self.clientSockets.count);
    NSLog(@"新连接用户 host:%@ port:%d", clientSocket.connectedHost, clientSocket.connectedPort);
}

// 当有客户端下线
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    for (MYAsyncSocket *socket in self.clientSockets) {
        if (socket.socket == sock) {
            [self.clientSockets removeObject:socket];
            
            NSLog(@"用户已下线 host:%@ port:%d", sock.connectedHost, sock.connectedPort);
            break;
        }
    }
}

// 读取客户端请求数据
- (void)socket:(GCDAsyncSocket *)clientSocket didReadData:(NSData *)data withTag:(long)tag
{
    // 1.读取数据
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    
    // 2.如果是心跳包更新时间
    if ([str isEqualToString:@"heart"]) {
        for (MYAsyncSocket *socket in self.clientSockets) {
            if (socket.socket == clientSocket) {
                socket.NewestDate = [NSDate date];
                break;
            }
        }
    }
    // 2.否则把当前客户端的数据群发给其他的客户端
    else {
        for (MYAsyncSocket *socket in self.clientSockets) {
            if (socket.socket != clientSocket) {
                [socket.socket writeData:data withTimeout:-1 tag:0];
            }
        }
    }

    // 3.监听客户端
    [clientSocket readDataWithTimeout:-1 tag:0];
}


#pragma mark - 心跳包
// 移除超过心跳时差的 client
- (void)repeatCheckClineOnline
{
    if (self.clientSockets.count == 0) return;
    
    NSMutableArray *repeatClients = [NSMutableArray array];
    for (MYAsyncSocket *socket in _clientSockets) {
        if ([[NSDate date] timeIntervalSinceDate:socket.NewestDate] > kHeartTime * 2) {
            [repeatClients addObject:socket];
            
            NSLog(@"用户已被心跳包机制搞下线 host:%@ port:%d", socket.socket.connectedHost, socket.socket.connectedPort);
        }
    }
    [_clientSockets removeObjectsInArray:repeatClients];
}

@end
