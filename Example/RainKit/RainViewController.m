//
//  RainViewController.m
//  RainKit
//
//  Created by 喻永权 on 02/28/2018.
//  Copyright (c) 2018 喻永权. All rights reserved.
//

#import "RainViewController.h"
#import <Masonry/Masonry.h>
#import <YYModel/YYModel.h>


@interface RainViewController ()<UITableViewDelegate,UITableViewDataSource,YYModel>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RainViewController{
    
    NSArray *_array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Rain的UI小组件";
    NSString *path = [[NSBundle mainBundle]pathForResource:@"RainKit" ofType:@"plist"];
    _array = [NSArray arrayWithContentsOfFile:path];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [_array[indexPath.row] objectForKey:@"className"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = _array[indexPath.row];
    UIViewController *vc = [[NSClassFromString(dict[@"classVC"]) alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}



- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
