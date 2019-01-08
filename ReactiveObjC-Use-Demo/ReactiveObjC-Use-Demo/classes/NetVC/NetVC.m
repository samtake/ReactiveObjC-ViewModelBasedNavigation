//
//  NetVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NetVC.h"
#import "BookViewModel.h"
#import "Book.h"

@interface NetVC ()
@property (nonatomic, strong) BookViewModel *bookVM;
@end

@implementation NetVC

- (BookViewModel *)bookVM {
    if (!_bookVM) {
        _bookVM = [[BookViewModel alloc] init];
    }
    return _bookVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *signal = [self.bookVM.requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        Book *book = x[0];
        NSLog(@"%@", book);
    }];
}

@end
