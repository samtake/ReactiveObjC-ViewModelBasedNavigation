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

// AppCaches 文件夹路径
#define XCachesDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
// App DocumentDirectory 文件夹路径
#define XDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject]

// 系统放大倍数
#define XScale [[UIScreen mainScreen] scale]

// 设置图片
#define XImageNamed(__imageName) [UIImage imageNamed:__imageName]

/// 根据hex 获取颜色
#define XColorFromHexString(__hexString__) ([UIColor colorFromHexString:__hexString__])

//  通知中心
#define XNotificationCenter [NSNotificationCenter defaultCenter]


/// 全局细下滑线颜色 以及分割线颜色
#define XGlobalBottomLineColor     [UIColor colorFromHexString:@"#D9D9D9"]

// 是否为空对象
#define XObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])

// 字符串为空
#define XStringIsEmpty(__string) ((__string.length == 0) || XObjectIsNil(__string))

// 字符串不为空
#define XStringIsNotEmpty(__string)  (!XStringIsEmpty(__string))

// 数组为空
#define XArrayIsEmpty(__array) ((MHObjectIsNil(__array)) || (__array.count==0))



//// --------------------  下面是公共配置  --------------------

/// 微信项目重要数据备份的文件夹名称（Documents/WeChatDoc）利用NSFileManager来访问
#define X_WECHAT_DOC_NAME  @"WeChatDoc"

/// 微信项目轻量数据数据备份的文件夹（Library/Caches/WeChatCache）利用NSFileManager来访问
#define X_WECHAT_CACHE_NAME  @"WeChatCache"

/// AppDelegate
#define XSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

////  整个应用的主题配置（颜色+字体）MAIN 代表全局都可以修改 使用前须知
#define X_MAIN_NAVIGATIONBAR_BACKGROUNDCOLOR_1 [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:0.65]
#define X_MAIN_NAVIGATIONBAR_BACKGROUNDCOLOR_2 [UIColor colorFromHexString:@"#EFEFF4"]
#define X_MAIN_NAVIGATIONBAR_BACKGROUNDCOLOR_3 [UIColor colorFromHexString:@"#F3F3F3"]
#define X_MAIN_NAVIGATIONBAR_BACKGROUNDCOLOR_4 [UIColor colorFromHexString:@"#E6A863"]
/// 全局青色 tintColor
#define X_MAIN_TINTCOLOR [UIColor colorWithRed:(10 / 255.0) green:(193 / 255.0) blue:(42 / 255.0) alpha:1]

/// 整个应用的视图的背景色 BackgroundColor
#define X_MAIN_BACKGROUNDCOLOR [UIColor colorFromHexString:@"#EFEFF4"]
/// 整个应用的分割线颜色
#define X_MAIN_LINE_COLOR_1 [UIColor colorFromHexString:@"#D9D8D9"]

/// 文字颜色
/// #56585f
#define X_MAIN_TEXT_COLOR_1 [UIColor colorFromHexString:@"#B2B2B2"]
/// #9CA1B2
#define X_MAIN_TEXT_COLOR_2 [UIColor colorFromHexString:@"#20DB1F"]
/// #FE583E
#define X_MAIN_TEXT_COLOR_3 [UIColor colorFromHexString:@"#FE583E"]
/// #0ECCCA
#define X_MAIN_TEXT_COLOR_4 [UIColor colorFromHexString:@"#0ECCCA"]
/// #3C3E44
#define X_MAIN_TEXT_COLOR_5 [UIColor colorFromHexString:@"#3C3E44"]

#endif /* SamMascros_h */
