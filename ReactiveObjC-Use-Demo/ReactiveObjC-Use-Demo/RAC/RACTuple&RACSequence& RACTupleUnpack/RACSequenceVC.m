//
//  RACSequenceVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "RACSequenceVC.h"
#import "Flag.h"

@interface RACSequenceVC ()

@end

@implementation RACSequenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self RACTuple];
    
    [self NSArray];
    
    [self NSDictionary];
    
    [self Model];
}

- (void)Model {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    // 方式一:
    //    NSMutableArray *arrayM = [NSMutableArray array];
    //    [dictArray.rac_sequence.signal subscribeNext:^(NSDictionary *x) {
    //        Flag *flag = [Flag flagWithDict:x];
    //        [arrayM addObject:flag];
    //    } completed:^{
    //        NSLog(@"%@", arrayM);
    //    }];
    
    // 方式二:
    NSArray *modelArray = [dictArray.rac_sequence map:^id(NSDictionary *value) {
        return [Flag flagWithDict:value];
    }].array;
    NSLog(@"模型");
    NSLog(@"%@", modelArray);
}


#pragma make - RACSequence：用于代替NSArray,NSDictionary,可以使用快速的遍历
- (void)NSDictionary {
    NSDictionary *dictionary = @{@"name": @"willing", @"age": @"26"};
    [dictionary.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        // 方式一:
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        //        NSLog(@"%@: %@", key, value);
        
        // 方式二:
        // RACTupleUnpack: 解析元组, 参数是解析出来的变量名, '=' 右边是被解析的元组
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"字典");
        NSLog(@"%@: %@", key, value);
    }];
}

- (void)NSArray {
    NSArray *array = @[@"hello", @"R", @"A", @"C", @"."];
    [array.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"数组");
        NSLog(@"%@", x);
    }];
}

- (void)RACTuple {
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"hello", @"R", @"A", @"C", @"."]];
    
    NSLog(@"元组tuple[0]%@", tuple[0]);
}

@end
