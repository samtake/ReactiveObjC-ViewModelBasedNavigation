//
//  BookViewModel1.h
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface BookViewModel1 : NSObject
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@property (nonatomic, copy, readonly) NSArray *books;
@end

NS_ASSUME_NONNULL_END
