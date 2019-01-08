//
//  XViewModelServices.h
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019 apple. All rights reserved.
//  视图模型服务层测协议 （导航栏操作的服务层 + 网络的服务层 ）

#import <Foundation/Foundation.h>
#import "XNavigationProtocol.h"
#import "MHHTTPService.h"
@protocol XViewModelServices <NSObject,XNavigationProtocol>
/// A reference to MHHTTPService instance.
/// 全局通过这个Client来请求数据，处理用户信息
@property (nonatomic, readonly, strong) MHHTTPService *client;
@end
