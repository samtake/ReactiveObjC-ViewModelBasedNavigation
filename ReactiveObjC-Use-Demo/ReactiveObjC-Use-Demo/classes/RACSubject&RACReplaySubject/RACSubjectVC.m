//
//  RACSubjectVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RACSubjectVC.h"
#import "CustomView.h"
@interface RACSubjectVC ()
@property (nonatomic, strong) CustomView *customView;
@end

@implementation RACSubjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self RACSubject];
    
    
    //像代理那样使用。
    _customView = [CustomView customView];
    _customView.center = self.view.center;
    [_customView.btnActionSignal subscribeNext:^(UIButton *x) {
        NSLog(@"testBtnAction: %@", x.currentTitle);
    }];
    [self.view addSubview:_customView];
    
    
    
    [self RACReplaySubject1];
}
/**
 // RACSubject:底层实现和RACSignal不一样。
 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock
 3.调用sendNext发送信号，不会保留原来的历史值，把最新的数据传递给订阅者
 通常用来代替代理
 */
- (void)RACSubject {
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者一接收到信号: %@", x);
    }];
    
    // 发送数据
    [subject sendNext:@"语文."];
    // 订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"订阅者二接收到信号: %@",x);
    }];
    NSLog(@"-------------------------------------------->");
    // 发送数据
    [subject sendNext:@"数学"];
    NSLog(@"============================================>");
}

/**
 RACReplaySubject可以先发送信号，在订阅信号，RACSubject就不可以
 同时会保留原来的历史数据，等待订阅者激活时接收数据
 */
- (void)RACReplaySubject {
    // 创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"订阅者一接收到信号: %@", x);
    }];
    
    // 发送数据
    [replaySubject sendNext:@"hhhhhhhhhhhhhhhhhhhhhhhhhhhh"];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"订阅者二接收到信号: %@",x);
    }];
    NSLog(@"三三三三三三三三三三三三三三三三三三三三三三三三三三三三三>");
    // 发送数据
    [replaySubject sendNext:@"fffffffffffffffffffffffffffff"];
   
}


-(void)RACReplaySubject1{
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    [replaySubject sendNext:@3];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
    [replaySubject sendNext:@4];
}
@end
