//
//  AppDelegate.h
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNavigationControllerStack.h"
#import "XViewModelServicesImpl.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
/// 窗口
@property (strong, nonatomic) UIWindow *window;

/// APP管理的导航栏的堆栈
@property (nonatomic, readonly, strong) XNavigationControllerStack *navigationControllerStack;

/// 获取AppDelegate
+ (AppDelegate *)sharedDelegate;

/// 是否已经弹出键盘 主要用于微信朋友圈的判断
@property (nonatomic, readwrite, assign , getter = isShowKeyboard) BOOL showKeyboard;


- (void)saveContext;


@end

