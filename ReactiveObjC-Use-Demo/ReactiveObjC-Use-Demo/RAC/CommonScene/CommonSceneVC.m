//
//  CommonSceneVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommonSceneVC.h"
#import "CSRedView.h"

#import <NSObject+RACKVOWrapper.h>//KVO

@interface CommonSceneVC ()
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)CSRedView *redView;
@end

@implementation CommonSceneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    
    [self RAC_delegate];
    
    [self RAC_KVO];
    
    [self RAC_events];
    
    [self RAC_notification];
    
    [self RAC_textFiled];
}

- (void)RAC_textFiled {
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)RAC_notification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification *x) {
        NSLog(@"UIKeyboardWillShowNotification: %@", x.userInfo);
    }];
}

- (void)RAC_events {
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        NSLog(@"Click button: %@", x.currentTitle);
    }];
}

- (void)RAC_KVO {
    [self.redView rac_observeKeyPath:@"frame"
                             options:NSKeyValueObservingOptionNew
                            observer:nil
                               block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
                                   NSLog(@"%@\n%@", value, change);
                               }];
    
    [[self.redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)RAC_delegate {
    // 方式一: RACSubject
    
    // 方式二: rac_signalForSelector
    [[self.redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id  _Nullable x) {
        NSLog(@"btnClick: %@", x);
        UIButton *button = x[0];
        NSLog(@"%@", button.currentTitle);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGRect newFrame = self.redView.frame;
    newFrame.size.height += 50;
    self.redView.frame = newFrame;
}











-(void)initUI{
    self.button = [UIButton new];
    [self.view addSubview:self.button];
    [self.button setTitle:@"button" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor  blackColor] forState:UIControlStateNormal];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.textField = [UITextField new];
    [self.textField  setBorderStyle:UITextBorderStyleBezel];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.button.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.redView = [[CSRedView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.redView];
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textField.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.mas_equalTo(self.view);
    }];
}

@end
