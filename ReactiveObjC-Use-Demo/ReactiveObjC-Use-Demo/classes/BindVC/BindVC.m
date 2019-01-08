//
//  BindVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BindVC.h"
#import <RACReturnSignal.h>
@interface BindVC ()

@end

@implementation BindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.原信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.绑定信号
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
        return ^RACSignal *(id value, BOOL *stop) {
            NSLog(@"原信号发送的内容: %@", value);
            value = [NSString stringWithFormat:@"解析后的%@",value];
            // 不能 return nil, 可以 return [RACSignal empty].
            return [RACReturnSignal return:value];
        };
    }];
    
    // 3.订阅绑定信号
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"绑定信号发送的内容: %@", x);
    }];
    
    // 4.原信号发送数据
    [subject sendNext:@"JSON数据"];
}

@end
