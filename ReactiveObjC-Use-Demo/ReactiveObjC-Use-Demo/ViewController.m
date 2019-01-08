//
//  ViewController.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/2.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import "RACSignalVC.h"
#import "RACDisposableVC.h"
#import "RACSubjectVC.h"
#import "RACSequenceVC.h"
#import "CommonSceneVC.h"
#import "DefineVC.h"
#import "RACMulticastConnectionVC.h"
#import "RACCommandVC.h"
#import "BindVC.h"
#import "MapVC.h"
#import "CombineVC.h"
#import "FilterVC.h"
#import "LoginVC.h"
#import "LoginVCmvvm.h"
#import "NetVC.h"
#import "NetVC1.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *aryData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aryData = [NSMutableArray new];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.aryData addObject:@{@"text":NSStringFromClass([RACSignalVC class]),@"detail":@"1.创建信号; 2.订阅信号; 3.发送信号;4.超时; 5.定时; 6.延时;"}];
    
    [self.aryData addObject:@{@"text":NSStringFromClass([RACDisposableVC class]),@"detail":@"它是block,1.订阅者被销毁时被调用 2.RACDisposable 调用dispose取消订阅"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([RACSubjectVC class]),@"detail":@"RACSubject、RACReplaySubject：三个知识点"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([RACSequenceVC class]),@"detail":@"元组解析、字典转模型"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([CommonSceneVC class]),@"detail":@"代理、KVO、events、通知、textField"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([DefineVC class]),@"detail":@"宏定义:RACObserve、RAC、rac_liftSelector(所有信号都发送数据后才会执行)"}];
    
    [self.aryData addObject:@{@"text":NSStringFromClass([RACMulticastConnectionVC class]),@"detail":@"被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([RACCommandVC class]),@"detail":@"宏定义:RACObserve、RAC、rac_liftSelector(所有信号都发送数据后才会执行)"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([BindVC class]),@"detail":@"绑定:bind"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([MapVC class]),@"detail":@"map、flattenMap:将我们的信号源的内容映射成为一个新的信号"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([CombineVC class]),@"detail":@"组合:concat、then、merge、zipWith、combineLatest"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([FilterVC class]),@"detail":@"过滤:filter、ignore、take、skip、distinctUntilChanged"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([LoginVC class]),@"detail":@"login"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([LoginVCmvvm class]),@"detail":@"login-mvvm"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([NetVC class]),@"detail":@"网络请求"}];
    [self.aryData addObject:@{@"text":NSStringFromClass([NetVC1 class]),@"detail":@"网络请求"}];
}


#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *VC = [[NSClassFromString([self.aryData[indexPath.row] valueForKey:@"text"])  alloc]init];
    [self.navigationController pushViewController:VC animated:true];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows ;
    rows=self.aryData.count;
    return rows;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.00f;
    height = 44.0f;
    return height;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 2.00f;
    
    if (section == 0){
        height = 0 ;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier=@"SearchResultCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = self.aryData[indexPath.row][@"text"];
    cell.detailTextLabel.text = self.aryData[indexPath.row][@"detail"];
    return cell;
}

@end
