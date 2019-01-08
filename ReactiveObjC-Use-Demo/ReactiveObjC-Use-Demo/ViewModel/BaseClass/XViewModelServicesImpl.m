//
//  XViewModelServicesImpl.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import "XViewModelServicesImpl.h"

@implementation XViewModelServicesImpl
@synthesize client = _client;
- (instancetype)init
{
    self = [super init];
    if (self) {
        _client = [MHHTTPService sharedInstance];
    }
    return self;
}


#pragma mark - SBNavigationProtocol empty operation
- (void)pushViewModel:(XViewModel *)viewModel animated:(BOOL)animated {}

- (void)popViewModelAnimated:(BOOL)animated {}

- (void)popToRootViewModelAnimated:(BOOL)animated {}

- (void)presentViewModel:(XViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion {}

- (void)resetRootViewModel:(XViewModel *)viewModel {}
@end
