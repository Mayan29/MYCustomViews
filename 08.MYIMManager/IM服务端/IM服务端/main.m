//
//  main.m
//  IM服务端
//
//  Created by mayan on 2017/10/25.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MYServerManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        MYServerManager *listener = [MYServerManager shareManager];
        [listener openServerWithPort:6001];
        
        // 开启主运行循环，让服务不能停
        [[NSRunLoop mainRunLoop] run];
    }
    return 0;
}
