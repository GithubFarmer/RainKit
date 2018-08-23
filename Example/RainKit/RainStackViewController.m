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
    
    NSArray *arr = @[[UIColor redColor],
                     [UIColor blueColor],
                     [UIColor greenColor]];
    for(int i = 0; i < 5; i++){
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = arr[arc4random()%3];
        [self.stackView addArrangedSubview:view];
    }
    _views = [NSMutableArray arrayWithArray:self.stackView.subviews];

    
}

- (void)deleteAction{
    [self.stackView removeArrangedSubview:self.stackView.subviews.lastObject];
//    [UIView animateWithDuration:0.2 animations:^{
//        [self.stackView layoutIfNeeded];
//    }];
  _views = [NSMutableArray arrayWithArray:self.stackView.subviews];
}

- (void)addClick{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    [self.stackView addArrangedSubview:view];
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
