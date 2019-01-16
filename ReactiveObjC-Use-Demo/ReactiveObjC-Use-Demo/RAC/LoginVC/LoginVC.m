//
//  LoginVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()
@property (strong, nonatomic)  UITextField *textField1;
@property (strong, nonatomic)  UITextField *textField2;
@property (strong, nonatomic)  UIButton *loginBtn;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    
    [self loginBtnEnable];
    
    [self loginAction];
}

- (void)loginBtnEnable {
    RACSignal *loginBtnEnableSiganl = [RACSignal combineLatest:@[self.textField1.rac_textSignal, self.textField2.rac_textSignal]
                                                        reduce:^id(NSString *account, NSString *pwd){
                                                            return @(account.length && pwd.length);
                                                        }];
    RAC(self.loginBtn, enabled) = loginBtnEnableSiganl;
}

- (void)loginAction {
    RACCommand *loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"完成登录请求"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    [loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [[loginCommand.executing skip:1] subscribeNext:^(id x) { // skip 1!
        if ([x boolValue] == YES) {
            [SVProgressHUD show];
            NSLog(@"正在执行命令");
        } else {
            [SVProgressHUD dismiss];
            NSLog(@"完成执行命令");
        }
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self myResignFirstResponder];
        [loginCommand execute:@"发送登录请求"];
    }];
}

- (void)myResignFirstResponder {
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
}


-(void)initUI{
    self.textField1 = [UITextField new];
    [self.textField1  setBorderStyle:UITextBorderStyleBezel];
    [self.view addSubview:self.textField1];
    [self.textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.textField2 = [UITextField new];
    [self.textField2  setBorderStyle:UITextBorderStyleBezel];
    [self.view addSubview:self.textField2];
    [self.textField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField1.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.loginBtn = [UIButton new];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn setTitle:@"login" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField2.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self myResignFirstResponder];
}

@end
