//
//  RainLeftViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/4/20.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainLeftViewController.h"
#import <Masonry/Masonry.h>
#import "RainViewConfigProtocol.h"

@interface RainLeftViewController ()<RainViewConfigProtocol>

@property (nonatomic, strong) UIView *baseView;

@end

@implementation RainLeftViewController{
    BOOL _isfirst;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.title = self.navigationController.title;
     self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/225.0 green:arc4random()%255/225.0 blue:arc4random()%255/225.0 alpha:1];
    self.baseView = [[UIView alloc] init];
    self.baseView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.baseView];
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
//        make.height.width.mas_equalTo(120);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES completion:NULL];
/**第一种做法*/
//        [self.baseView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.mas_equalTo(20);
//            make.right.mas_equalTo(-20);
//            make.height.mas_equalTo(120);
//        }];
/**第二种做法*/
    [self.baseView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(220);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.baseView layoutIfNeeded];
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
