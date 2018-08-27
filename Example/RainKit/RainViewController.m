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
#import "UIViewController+RainNav.h"
#import <RainKit/RainServiceManager.h>
#import <RainKit/RainHeader.h>
#import <RainKit/RainServiceTestProtocol.h>
#import "RainViewConfigProtocol.h"
#import "RainCenterViewController.h"
#import "RainLeftViewController.h"
#import "RainTabBarController.h"

@interface RainViewController ()<UITableViewDelegate,UITableViewDataSource,YYModel,RainViewConfigProtocol>

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
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];//梯度图层
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
//    vc.view.backgroundColor = [UIColor whiteColor];
    if([dict[@"className"] containsString:@"Protocol"]){
        
        UIViewController<RainServiceTestProtocol> *protocolVC = [RainServiceManager createServiceWithProtocol:@protocol(RainServiceTestProtocol)];
        [self.navigationController pushViewController:protocolVC animated:YES];
    
    }else if([dict[@"classVC"] isEqualToString:@"RainHoriViewController"]){
        RainBaseViewController *hNvc = [vc getNavForPresented];
        hNvc.title = vc.title;
//        [self presentViewController:hNvc animated:NO completion:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([dict[@"className"] isEqualToString:@"tabbar"]){
        [self presentViewController:[self setUpRootViewController] animated:YES completion:NULL];
    }else{
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (RainTabBarController *)setUpRootViewController{
    
    RainCenterViewController *centerVC = [RainCenterViewController new];
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:centerVC];
    nvc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    //    nvc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home"];
    nvc1.title = @"家庭";
    RainLeftViewController *leftVC = [RainLeftViewController new];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:leftVC];
    nvc2.tabBarItem.image  = [UIImage imageNamed:@"tabbar_message_center"];
    nvc2.title = @"信心";
    RainLeftViewController *leftVC1 = [RainLeftViewController new];
    UINavigationController *nvc3 = [[UINavigationController alloc]initWithRootViewController:leftVC1];
    nvc3.tabBarItem.image  = [UIImage imageNamed:@"tabbar_discover"];
    nvc3.title = @"发现";
    RainLeftViewController *leftVC2 = [RainLeftViewController new];
    UINavigationController *nvc4 = [[UINavigationController alloc]initWithRootViewController:leftVC2];
    nvc4.tabBarItem.image  = [UIImage imageNamed:@"tabbar_profile"];
    nvc4.title = @"提升";
    RainTabBarController *tabVC = [RainTabBarController new];
    tabVC.viewControllers = @[nvc1,nvc2,nvc3,nvc4];
    [tabVC setPlusBlock:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    return tabVC;
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
