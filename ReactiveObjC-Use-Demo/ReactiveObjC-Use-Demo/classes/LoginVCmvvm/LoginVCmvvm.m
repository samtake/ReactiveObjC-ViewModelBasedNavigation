//
//  LoginVCmvvm.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "LoginVCmvvm.h"
#import "LoginViewModel.h"



@interface LoginVCmvvm ()
@property (strong, nonatomic)  UITextField *textField1;
@property (strong, nonatomic)  UITextField *textField2;
@property (strong, nonatomic)  UIButton *loginBtn;

@property (nonatomic, strong) LoginViewModel *loginVM;


@end

@implementation LoginVCmvvm

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    
    RAC(self.loginVM, username) = self.textField1.rac_textSignal;
    RAC(self.loginVM, password) = self.textField2.rac_textSignal;
    
    RAC(self.loginBtn, enabled) = self.loginVM.loginBtnEnableSignal;
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self myResignFirstResponder];
        [self.loginVM.loginCommand execute:@"发送登录请求"];
    }];
    
}

- (LoginViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
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
