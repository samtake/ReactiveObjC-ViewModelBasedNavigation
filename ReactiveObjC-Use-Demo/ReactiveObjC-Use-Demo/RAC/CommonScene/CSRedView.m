//
//  CSRedView.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/3.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CSRedView.h"
#import <Masonry.h>
@implementation CSRedView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
-(void)initUI{
    [self setBackgroundColor:[UIColor redColor]];
    self.btn = [UIButton new];
    [self addSubview:self.btn];
    [self.btn setTitle:@"red button" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(self);
        make.height.mas_equalTo(50);
        make.centerY.mas_equalTo(self);
    }];
}


-(void)btnClick:(UIButton *)sender{
    
}
@end
