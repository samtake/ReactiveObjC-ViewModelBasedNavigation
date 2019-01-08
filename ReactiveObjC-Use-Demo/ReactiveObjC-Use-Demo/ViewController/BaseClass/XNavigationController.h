//
//  SamNavigationController.h
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XNavigationController : UINavigationController
/// 显示导航栏的细线
- (void)showNavigationBottomLine;
/// 隐藏导航栏的细线
- (void)hideNavigationBottomLine;
@end

NS_ASSUME_NONNULL_END
