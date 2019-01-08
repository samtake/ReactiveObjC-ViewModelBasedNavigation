//
//  LoginViewModel.h
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong, readonly) RACSignal  *loginBtnEnableSignal;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
