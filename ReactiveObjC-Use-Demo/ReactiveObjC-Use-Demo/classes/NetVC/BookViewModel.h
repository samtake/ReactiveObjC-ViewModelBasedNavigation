//
//  BookViewModel.h
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface BookViewModel : NSObject
@property (nonatomic, strong, readonly) RACCommand *requestCommand;
@end

NS_ASSUME_NONNULL_END
