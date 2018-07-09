//
//  RainMasonryViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/5/18.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainMasonryViewController.h"
#import <Masonry/Masonry.h>

@interface RainMasonryViewController ()

@end

@implementation RainMasonryViewController
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *_arrViews = [NSMutableArray new];
    for(int i = 0 ; i < 5; i++){
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        [_arrViews addObject:view];
        [self.view addSubview:view];
    }
    //masory直线布局，间距一定，长度或者宽度会变化
//    [_arrViews mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:10 leadSpacing:80 tailSpacing:40];
//    [_arrViews mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(30);
//        make.width.mas_equalTo(80);
//        make.left.mas_equalTo(30);
//    }];
    //masonry直线布局，长度或者宽度一定，间距会发生变化
    [_arrViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:40 leadSpacing:10 tailSpacing:10];
    [_arrViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
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
