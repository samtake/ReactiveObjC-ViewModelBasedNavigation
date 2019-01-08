//
//  RACSignalVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RACSignalVC.h"

@interface RACSignalVC ()

@end

@implementation RACSignalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicUseSignal];
    
    //    [self timeout];
    
    //    [self interval];
    
    //    [self delay];
}

- (void)basicUseSignal {
    // RACSignal 使用步骤: 1.创建信号; 2.订阅信号; 3.发送信号;
    
    // 1.创建信号(冷信号)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 3.发送信号
        [subscriber sendNext:@"hello, RAC."];
        return nil;
    }];
    // 2.订阅信号(热信号)
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // RACDynamicSignal 信号执行顺序(注意: 不同类型的信号处理的方式不同)
    // 1. 订阅信号会执行, 创建信号时传入的 didSubscribe block 参数里的代码
    // 2. 发送信号会执行, 订阅信号时传入的 nextBlock block 参数里的代码
}

- (void)timeout {
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"hello, RAC."];
        return nil;
    }] timeout:3.0 onScheduler:[RACScheduler currentScheduler]];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    } error:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)interval {
    [[RACSignal interval:3.0 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)delay {
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"hello, RAC."];
        return nil;
    }] delay:2.0] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

@end
