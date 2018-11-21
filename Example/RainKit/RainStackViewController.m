//
//  RainStackViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/8/7.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainStackViewController.h"
#import <Masonry/Masonry.h>

@interface RainStackViewController ()

@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation RainStackViewController{
    NSMutableArray *_views;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.stackView = [[UIStackView alloc]init];
    self.stackView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.stackView];

    
//    UIStackViewAlignmentFill,
//    UIStackViewAlignmentLeading,
//    UIStackViewAlignmentTop = UIStackViewAlignmentLeading,
//    UIStackViewAlignmentFirstBaseline,
//    UIStackViewAlignmentCenter,
//    UIStackViewAlignmentTrailing,
//    UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing,
//    UIStackViewAlignmentLastBaseline,
    //stackView的对齐方式
    self.stackView.alignment = UIStackViewAlignmentFill;
    
    //    UIStackViewDistributionFill = 0,
    //    UIStackViewDistributionFillEqually,
    //    UIStackViewDistributionFillProportionally,
    //    UIStackViewDistributionEqualSpacing,
    //    UIStackViewDistributionEqualCentering,
    self.stackView.distribution = UIStackViewDistributionFillProportionally;

    
    //    UILayoutConstraintAxisVertical
    //    UILayoutConstraintAxisHorizontal
    self.stackView.axis = UILayoutConstraintAxisVertical;

    self.stackView.spacing = 10;
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(15);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(250);
    }];
    
    UIButton *leftBtn = [UIButton new];
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn setTitle:@"删除" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = [UIButton new];
    rightBtn.backgroundColor = [UIColor blackColor];
    [rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [self.view addSubview:rightBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-30);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.size.bottom.equalTo(leftBtn);
    }];

    for(int i = 0; i < 5; i++){
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [self randColor];
        [self.stackView addArrangedSubview:view];
    }
}

- (UIColor *)randColor{
    UIColor *color = [UIColor colorWithRed:rand()%225/225.0 green:rand()%225/225.0 blue:rand()%225/225.0 alpha:1];
    return color;
}

- (void)deleteAction{
    [self.stackView insertArrangedSubview:self.stackView.subviews.lastObject atIndex:0];
    [UIView animateWithDuration:0.2 animations:^{
        [self.stackView layoutIfNeeded];
    }];
}

- (void)addClick{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [self randColor];
    
    NSInteger num = rand()%10;
    if(num%2){
        [self.stackView addArrangedSubview:view];
    }else{
        [self.stackView insertArrangedSubview:self.stackView.subviews.lastObject atIndex:0];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.stackView layoutIfNeeded];
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
