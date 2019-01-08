//
//  RACCommandVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 apple. All rights reserved.
//
/**
 RACSubject与RACCommand
 
 RACSubject: sendNext 事件单向传递
 RACCommand: execute--》订阅者兼事件生产者  《---sendNext
 */

#import "RACCommandVC.h"

@interface RACCommandVC ()

@end

@implementation RACCommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self RACCommand];
    
    //    [self executionSignals];
    
    //    [self switchToLatest];
    
    //    [self executing];
}

- (void)executing {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"执行命令产生的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在执行命令");
        } else {
            NSLog(@"命令没有执行/命令执行完成");
        }
    }];
    
    [command execute:@"执行命令"];
}

- (void)switchToLatest {
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    // 订阅信号
    //    [signalOfSignals subscribeNext:^(RACSignal *x) {
    //        [x subscribeNext:^(id x) {
    //            NSLog(@"%@",x);
    //        }];
    //    }];
    [signalOfSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [signalOfSignals sendNext:signalA];
    [signalA sendNext:@"A信号发送数据"];
    [signalB sendNext:@"B信号发送数据"];
    [signalA sendNext:@"A信号发送数据"];
}

- (void)executionSignals {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"执行命令产生的数据"];
            return nil;
        }];
    }];
    
    // 注意: 必须先订阅信号再执行命令
    //executionSignals: 信号源, 即发送数据是信号
    //    [command.executionSignals subscribeNext:^(RACSignal *x) {
    //        [x subscribeNext:^(id x) {
    //            NSLog(@"%@", x);
    //        }];
    //    }];
    
    // switchToLatest 得到信号源最新发送的信号.(注意: 必须先 switchToLatest 再 execute)
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [command execute:@"执行命令"];
}

- (void)RACCommand {
    // RACCommand
    // 使用场景: 1.监听按钮点击事件; 2.发送网络请求等;
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"执行命令产生的数据"];
            return nil;
        }];
    }];
    
    RACSignal *signal = [command execute:@"执行命令"];
    
    // execute 使用的是 RACReplaySubject, 所以可以先执行命令, 再订阅信号
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

@end
