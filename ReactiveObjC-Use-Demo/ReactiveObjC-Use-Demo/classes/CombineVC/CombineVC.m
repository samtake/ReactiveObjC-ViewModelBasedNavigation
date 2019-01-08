//
//  CombineVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CombineVC.h"

@interface CombineVC ()
@property (strong, nonatomic)  UITextField *textField1;
@property (strong, nonatomic)  UITextField *textField2;
@property (strong, nonatomic)  UIButton *loginBtn;
@end

@implementation CombineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    //    [self concat];
    
    //    [self then];
    
    //    [self merge];
    
    //    [self zipWith];
    
//    [self combineLatest];
}
//将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext（不是同时），才会触发合并的信号
- (void)combineLatest {
    RACSignal *comineSiganl = [RACSignal combineLatest:@[self.textField1.rac_textSignal, self.textField2.rac_textSignal]
                                                reduce:^id _Nullable(NSString *username, NSString *password){
                                                    NSLog(@"username: %@, password: %@", username, password);
                                                    return @(username.length && password.length);
                                                }];
    // 订阅组合信号
    //    [comineSiganl subscribeNext:^(id x) {
    //        _loginBtn.enabled = [x boolValue];
    //    }];
    RAC(_loginBtn, enabled) = comineSiganl;
}

- (void)zipWith {
    // 需求: 一个界面有多个请求, 所有请求完成才更新 UI.
    // 把两个信号压缩成一个信号，只有当两个信号同时（同时同时同时）发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件
    // 注意：使用 zipWith 时，两个信号必须同时发出信号内容
    

    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSignal *zipSignal = [signalA zipWith:signalB];
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [signalA sendNext:@"数据A"];
    [signalB sendNext:@"数据B"];
}

- (void)merge {
    // 任意信号发送完成都会调用 nextBlock block.
    // 把多个信号合并为一个信号，任何一个信号有新值的时候就会调用
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSignal *mergeSiganl = [signalA merge:signalB];
    [mergeSiganl subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    [signalA sendNext:@"数据A"];
    [signalB sendNext:@"数据B"];
}

- (void)then {
    RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送A请求");
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送B请求");
        [subscriber sendNext:@"数据B"];
        return nil;
    }];
    
    // then: 组合信号, 忽悠掉第一个信号.
    // 用于连接两个信号，当第一个信号完成，才会连接then返回的信号
    RACSignal *thenSiganl = [siganlA then:^RACSignal *{
        return siganlB; // 需要组合的信号
    }];
    
    [thenSiganl subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)concat {
    RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送A请求");
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送B请求");
        [subscriber sendNext:@"数据B"];
        return nil;
    }];
    
    // concat: 顺序链接组合信号，按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号
    // 注意: concat 方法的 第一个信号必须要调用 sendCompleted.
    RACSignal *concatSignal = [siganlA concat:siganlB];
    
    [concatSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}


-(void)initUI{
    
    self.textField1 = [UITextField new];
    [self.textField1  setBorderStyle:UITextBorderStyleBezel];
    [self.view addSubview:self.textField1];
    [self.textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(50);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.textField2 = [UITextField new];
    [self.textField2  setBorderStyle:UITextBorderStyleBezel];
    [self.view addSubview:self.textField2];
    [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField1.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.loginBtn = [UIButton new];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn setTitle:@"login" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField2.mas_bottom).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
}


@end
