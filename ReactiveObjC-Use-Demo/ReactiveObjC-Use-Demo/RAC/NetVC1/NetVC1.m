//
//  NetVC1.m
//  ReactiveObjC-Use-Demo
//
//  Created by apple on 2019/1/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "NetVC1.h"
#import "BookViewModel1.h"
#import "Book.h"

@interface NetVC1 ()<UITableViewDataSource>
@property (nonatomic, strong) BookViewModel1 *bookVM;
@end

@implementation NetVC1

- (BookViewModel1 *)bookVM {
    if (!_bookVM) {
        _bookVM = [[BookViewModel1 alloc] init];
    }
    return _bookVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [self.bookVM.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        [tableView reloadData];
    }];
    
    //    @weakify(self);
    //    [self.bookVM.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
    //        @strongify(self);
    //        [self.tableView reloadData];
    //    }];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"q"] = @"基础";
    [self.bookVM.requestCommand execute:parameters];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookVM.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    Book *book = self.bookVM.books[indexPath.row];
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    return cell;
}
@end
