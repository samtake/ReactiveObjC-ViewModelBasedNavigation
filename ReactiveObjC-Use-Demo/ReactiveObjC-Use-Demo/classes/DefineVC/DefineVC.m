//
//  DefineVC.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "DefineVC.h"

@interface DefineVC ()
@property (strong, nonatomic)  UILabel *label;
@property (strong, nonatomic)  UITextField *textField;


@property (nonatomic, strong) RACSignal *signal;
@end

@implementation DefineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    
    
    //RACTuplePack：把数据包装成RACTuple（元组类）
    // 把参数中的数据包装成元组
    RACTuple *tuple = RACTuplePack(@10,@20);
    NSLog(@"tuple=%@",tuple);
    //RACTupleUnpack：把RACTuple（元组类）解包成对应的数据。
    // 把参数中的数据包装成元组
    RACTuple *tuple1 = RACTuplePack(@"xmg",@20);
    NSLog(@"tuple1=%@",tuple1);
    // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
    // name = @"xmg" age = @20
    RACTupleUnpack(NSString *name,NSNumber *age) = tuple;
    NSLog(@"name=%@,age=%@",name,age);
    
    RACTuple *tuple2 = RACTuplePack(@"hello", @"RAC");
    NSLog(@"tuple2[0]=%@", tuple2[0]);
    
    
    //观察self.view的frame，当frame变化的时候会响应
    [RACObserve(self.view, frame) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    
    
    //    [_textField.rac_textSignal subscribeNext:^(id x) {
    //        _label.text = x;
    //    }];
    
    //用于给某个对象的某个属性绑定。（textF的文本付给label的text属性）
    RAC(_label, text) = _textField.rac_textSignal;
    
    
    
    
    
}

/**
 有一个需要注意的问题：在block内部尽量用self来引用控制器的成员变量， 这样子如果有循环引用的时候可以用“信号外部用@weakify，内部用@strongify”这个方式来解决，如果直接用“_”来引用成员变量，可能会解决不了循环引用的问题
 */
-(void)loop{
    //问题：在信号中打印了控制器，也就是强引用了控制器，控制器中又强引用了信号，如下，就会形成循环应用
    //信号外部用@weakify，内部用@strongify
    @weakify(self);
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"zhangdanfeng"];
        
        @strongify(self);
        NSLog(@"%@",self);
        return  nil;
    }];
    
    //这里是强引用
    self.signal = signal;
    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self liftSelector];
}

- (void)liftSelector {
    // 需求: 多个请求全部完成后再刷新 UI
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"请求热销模块数据");
        [subscriber sendNext:@"热销模块数据"];
        return nil;
    }];
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"请求最新模块数据");
        [subscriber sendNext:@"最新模块数据"];
        return nil;
    }];
    // withSignalsFromArray 中的所有信号都发送数据后才会执行 selector, selector 的参数就是每个信号发送的数据
    [self rac_liftSelector:@selector(updateUIWithHotData:newData:) withSignalsFromArray:@[hotSignal, newSignal]];
}

- (void)updateUIWithHotData:(NSString *)hotData newData:(NSString *)newData {
    // 刷新 UI
    NSLog(@"%@", hotData);
    NSLog(@"%@", newData);
}


-(void)initUI{
    self.label = [UILabel new];
    self.label.numberOfLines=0;
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.textField = [UITextField new];
    [self.textField  setBorderStyle:UITextBorderStyleBezel];
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.centerX.mas_equalTo(self.view);
    }];
}
@end
