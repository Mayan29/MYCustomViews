//
//  MYServerManager.h
//  MYServer
//
//  Created by mayan on 2017/10/25.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYServerManager : NSObject

+ (instancetype)shareManager;

- (BOOL)openServerWithPort:(uint16_t)port;

@end
