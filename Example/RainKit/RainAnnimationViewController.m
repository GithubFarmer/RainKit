//
//  RainAnnimationViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/26.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainAnnimationViewController.h"
#import "RainViewConfigProtocol.h"
#import "RainAnnimation_one_ViewController.h"
#import "RainAnnimation_two_ViewController.h"
#import <RainKit/RainHeader.h>
#import "RainAnnimation_Three_ViewController.h"
#import "RainAnnimation_Four_ViewController.h"
#import "RainAnnimation_Five_ViewController.h"

#import <Masonry/Masonry.h>

@interface RainAnnimationViewController ()<UITableViewDelegate,UITableViewDataSource,RainViewConfigProtocol>

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, copy) NSArray *describleArray;

@property (nonatomic, copy) NSArray *vcArray;

@end

@implementation RainAnnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"转场动画";
    _dataSource = @[@"present/dismiss转场1",@"push/pop转场2",@"present/dismiss转场3",@"push/pop转场4",@"push/pop转场5"];
    _describleArray = @[@"新浪微博图集浏览器专场效果",@"手势过渡动画",@"网易音乐启动屏转场动画",@"开关门动画",@"全屏策划部返回、UIScrolllView、UISlider三折手势滑动事件冲突"];
    _vcArray = @[[RainAnnimation_one_ViewController class],[RainAnnimation_two_ViewController class],[RainAnnimation_Three_ViewController class],[RainAnnimation_Four_ViewController class],[RainAnnimation_Five_ViewController class]];
    self.tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    cell.imageView.image = [UIImage imageNamed:@"piao"];
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.detailTextLabel.text = _describleArray[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.currentIndexPath = indexPath;
    if(_vcArray[indexPath.row] == [RainAnnimation_one_ViewController class]){
        RainAnnimation_one_ViewController *vc = [RainAnnimation_one_ViewController new];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:vc animated:YES completion:nil];
        });
    }else if (_vcArray[indexPath.row] == [RainAnnimation_two_ViewController class]){
        RainAnnimation_two_ViewController *vc = [RainAnnimation_two_ViewController new];
        self.navigationController.delegate = vc;
        [self.navigationController pushViewController:vc animated:NO];
    }else if (_vcArray[indexPath.row] == [RainAnnimation_Three_ViewController class]){
        RainAnnimation_Three_ViewController *vc = [RainAnnimation_Three_ViewController new];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (_vcArray[indexPath.row] == [RainAnnimation_Four_ViewController class]){
        RainAnnimation_Four_ViewController *vc = [RainAnnimation_Four_ViewController new];
        self.navigationController.delegate = vc;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(_vcArray[indexPath.row] == [RainAnnimation_Five_ViewController class]){
        RainAnnimation_Five_ViewController *vc = [RainAnnimation_Five_ViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.delegate = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
