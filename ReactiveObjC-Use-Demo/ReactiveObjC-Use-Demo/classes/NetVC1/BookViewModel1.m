//
//  BookViewModel1.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BookViewModel1.h"
#import <AFNetworking.h>
#import "Book.h"
@implementation BookViewModel1
- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@", input);
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [[AFHTTPSessionManager manager] GET:@"https://api.douban.com/v2/book/search"
                                              parameters:input
                                                 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                     [subscriber sendNext:responseObject];
                                                     [subscriber sendCompleted];
                                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                     [subscriber sendError:error];
                                                 }];
            return nil;
        }];
        
        return [requestSignal map:^id _Nullable(id  _Nullable value) {
            NSMutableArray *dictArray = value[@"books"];
            NSArray *modelArray = [dictArray.rac_sequence map:^id(id value) {
                return [Book bookWithDict:value];
            }].array;
            _books = modelArray;
            return nil;
            //return modelArray;
        }];
    }];
}
@end
