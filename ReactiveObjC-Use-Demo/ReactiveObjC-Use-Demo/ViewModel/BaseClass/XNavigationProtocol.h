//
//  XNavigationProtocol.h
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019 apple. All rights reserved.
//  关于导航栏跳转（Push/Pop   Present/Dismiss）的协议


#import <Foundation/Foundation.h>
#import "XViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol XNavigationProtocol <NSObject>
/// Pushes the corresponding view controller.
///
/// Uses a horizontal slide transition.
/// Has no effect if the corresponding view controller is already in the stack.
///
/// viewModel - the view model
/// animated  - use animation or not
- (void)pushViewModel:(XViewModel *)viewModel animated:(BOOL)animated;

/// Pops the top view controller in the stack.
///
/// animated - use animation or not
- (void)popViewModelAnimated:(BOOL)animated;

/// Pops until there's only a single view controller left on the stack.
///
/// animated - use animation or not
- (void)popToRootViewModelAnimated:(BOOL)animated;

/// Present the corresponding view controller.
///
/// viewModel  - the view model
/// animated   - use animation or not
/// completion - the completion handler
- (void)presentViewModel:(XViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

/// Dismiss the presented view controller.
///
/// animated   - use animation or not
/// completion - the completion handler
- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;

/// Reset the corresponding view controller as the root view controller of the application's window.
///
/// viewModel - the view model
- (void)resetRootViewModel:(XViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
