//
//  RainProtocolTestViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/10.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainProtocolTestViewController.h"
#import <RainKit/RainServiceManager.h>
#import <RainKit/RainServiceTestProtocol.h>
#import "RainViewConfigProtocol.h"
#import <RainKit/RainCircleView.h>
#import <Masonry/Masonry.h>

@interface RainProtocolTestViewController ()<RainCircleViewDataSource>
//<RainServiceTestProtocol,RainViewConfigProtocol>

@property (nonatomic, strong) RainCircleView *cirCleView;

@end

@implementation RainProtocolTestViewController

+ (void)load{
    [RainServiceManager registerServiceWithProtocol:@protocol(RainServiceTestProtocol) service:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.cirCleView = [RainCircleView new];
    self.cirCleView.dataSource = self;
    [self.view addSubview:self.cirCleView];
    [self.cirCleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_equalTo(300);
    }];
    
}

- (NSInteger)numberOfItemInCircleView:(RainCircleView *)circleView{
    return 3;
}

- (NSNumber *)ratioOfItemInCircleView:(RainCircleView *)circleView itemAtIndex:(NSInteger)index{
    return @3;
}

- (UIColor *)colorOfItemInCircleView:(RainCircleView *)circleView itemAtIndex:(NSInteger)index{
    NSArray *arr = @[[UIColor redColor],[UIColor blueColor],[UIColor orangeColor]];
    return arr[index];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.cirCleView reloadCircleView];
}

- (void)circleView:(RainCircleView *)circleView selectedItemAtIndex:(NSInteger)index{
    
    NSLog(@"=======点击了第：%d个layer",(int)index);
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
