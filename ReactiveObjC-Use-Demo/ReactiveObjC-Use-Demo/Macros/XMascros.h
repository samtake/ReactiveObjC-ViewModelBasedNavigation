//
//  SamMascros.h
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019 apple. All rights reserved.
//

#ifndef XMascros_h
#define XMascros_h


/// 存储应用版本的key
#define XApplicationVersionKey   @"SBApplicationVersionKey"
/// 应用名称
#define X_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
/// 应用版本号
#define X_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
/// 应用build
#define X_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])



// 输出日志 (格式: [时间] [哪个方法] [哪行] [输出内容])
#ifdef DEBUG
#define NSLog(format, ...)  printf("\n[%s] %s [第%d行] 💕 %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else

#define NSLog(format, ...)

#endif
// 打印方法
#define XLogFunc NSLog(@"%s", __func__)
// 打印请求错误信息
#define XLogError(error) NSLog(@"Error: %@", error)
// 销毁打印
#define XDealloc NSLog(@"\n =========+++ %@  销毁了 +++======== \n",[self class])

#define XLogLastError(db) NSLog(@"lastError: %@, lastErrorCode: %d, lastErrorMessage: %@", [db lastError], [db lastErrorCode], [db lastErrorMessage]);





/// 类型相关
#define X_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define X_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define X_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

/// 屏幕尺寸相关
#define X_SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define X_SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define X_SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])
#define X_SCREEN_MAX_LENGTH (MAX(X_SCREEN_WIDTH, X_SCREEN_HEIGHT))
#define X_SCREEN_MIN_LENGTH (MIN(X_SCREEN_WIDTH, X_SCREEN_HEIGHT))

/// 手机类型相关
#define X_IS_IPHONE_4_OR_LESS  (X_IS_IPHONE && X_SCREEN_MAX_LENGTH  < 568.0)
#define X_IS_IPHONE_5          (X_IS_IPHONE && X_SCREEN_MAX_LENGTH == 568.0)
#define x_IS_IPHONE_6          (X_IS_IPHONE && X_SCREEN_MAX_LENGTH == 667.0)
#define X_IS_IPHONE_6P         (X_IS_IPHONE && X_SCREEN_MAX_LENGTH == 736.0)
#define X_IS_IPHONE_X          (X_IS_IPHONE && X_SCREEN_MAX_LENGTH == 812.0)


/// 导航条高度
#define X_APPLICATION_TOP_BAR_HEIGHT (X_IS_IPHONE_X?88.0f:64.0f)
/// tabBar高度
#define X_APPLICATION_TAB_BAR_HEIGHT (X_IS_IPHONE_X?83.0f:49.0f)
/// 工具条高度 (常见的高度)
#define X_APPLICATION_TOOL_BAR_HEIGHT_44  44.0f
#define X_APPLICATION_TOOL_BAR_HEIGHT_49  49.0f
/// 状态栏高度
#define X_APPLICATION_STATUS_BAR_HEIGHT (X_IS_IPHONE_X?44:20.0f)


// 颜色
#define XColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 颜色+透明度
#define XColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 随机色
#define XRandomColor XColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
// 根据rgbValue获取对应的颜色

#endif /* SamMascros_h */
