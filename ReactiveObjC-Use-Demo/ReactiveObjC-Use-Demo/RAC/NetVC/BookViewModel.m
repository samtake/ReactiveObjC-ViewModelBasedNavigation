//
//  BookViewModel.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BookViewModel.h"
#import <AFNetworking.h>
#import "Book.h"
@implementation BookViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q": @"动物"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //NSLog(@"%@---%@",[responseObject class],responseObject);
                NSArray *dictArray = responseObject[@"books"];
                NSArray *modelArray = [dictArray.rac_sequence map:^id(id value) {
                    return [Book bookWithDict:value];
                }].array;
                [subscriber sendNext:modelArray];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //NSLog(@"请求失败--%@",error);
                [subscriber sendError:error];
            }];
            return nil;
        }];
        return requestSignal;
    }];
}

@end
