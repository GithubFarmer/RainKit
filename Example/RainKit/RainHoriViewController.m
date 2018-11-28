//
//  RainHoriViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/7/9.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainHoriViewController.h"
#import "RainViewConfigProtocol.h"
#import "UIViewController+RainRotation.h"


@interface RainHoriViewController ()<RainViewConfigProtocol>

@property (nonatomic, strong) NSString *string;

@property (nonatomic, strong) NSArray *arr1;

@property (nonatomic, copy) NSArray *arr2;

@property (nonatomic, strong) NSString *rStr;

@property (nonatomic, copy) NSString *cStr;

@property (nonatomic, copy) NSMutableArray *dataArray;

@property (nonatomic, copy) NSMutableString *mutableString;

@end

@implementation RainHoriViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"横屏界面";
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor yellowColor];
    CGPoint centerPoint = CGPointMake(CGRectGetWidth(self.view.bounds)/2.f, CGRectGetHeight(self.view.bounds)/2.f);
//    view.layer.borderWidth = 20;
//    view.layer.borderColor = [UIColor redColor].CGColor;
    view.center = centerPoint;
    view.bounds = CGRectMake(0, 0, 300, 400);
    [self.view addSubview:view];
    CGPoint centerPoint1 = CGPointMake(CGRectGetWidth(view.bounds)/2.f, CGRectGetHeight(view.bounds)/2.f);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:centerPoint1 radius:150-10 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    layer.strokeColor = [UIColor brownColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 20;
    layer.strokeEnd = 1;
    layer.strokeStart = 0;
    [view.layer addSublayer:layer];
    NSDictionary *dict = @{@"sex":@"1",
                           @"schoolname":@"广西外国语学院",
                           @"firstmajor":@"ww",
                           @"secondmajorcode":@"96b4edc6abf211e89a44000c29028ff2",
                           @"departmentcode":@"749e6cccab6a11e89a44000c29028ff2",
                           @"cardid":@"www",
                           @"departmentname":@"国际经济与贸易系",
                           @"schoolcode":@"1489e61bab5e11e89a44000c29028ff2",
                           @"telphone":@"我们",
                           @"sno":@"www",
                           @"failsubject":@"1",
                           @"secondmajor":@"国际经济与贸易和金融工程",
                           @"grade":@"大一",
                           @"name":@"wq"};
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@:%@",data,dataString);

    _arr2 = @[@1,@3];
    _arr2 = @[@3,@1];
    _arr1 = @[@1,@3];
    _arr1 = @[@3,@1];
    NSMutableString *mStr = [NSMutableString stringWithFormat:@"abc"];
    self.rStr   = mStr;
    self.cStr     = mStr;
    NSLog(@"mStr:%p,%p",  mStr,&mStr);
    NSLog(@"retainStr:%p,%p", _rStr, &_rStr);
    NSLog(@"copyStr:%p,%p",   _cStr, &_cStr);
    
    [mStr appendString:@"de"];
    NSLog(@"retainStr:%@",  _rStr);
    NSLog(@"copyStr:%@",    _cStr);

    _mutableString = [NSMutableString stringWithFormat:@"abc"];
    self.rStr   = _mutableString;
    self.cStr     = _mutableString;
    NSLog(@"mStr:%p,%p",  _mutableString,&_mutableString);
    NSLog(@"retainStr:%p,%p", _rStr, &_rStr);
    NSLog(@"copyStr:%p,%p",   _cStr, &_cStr);
    
    [_mutableString appendString:@"de"];
    NSLog(@"retainStr:%@,%p,%p",  _rStr,_mutableString,&_mutableString);
    NSLog(@"copyStr:%@",    _cStr);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)isFullScreenMode{
    return YES;
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (BOOL)isLandScape{
    return NO;
}

//iOS9以后，状态丢失的情况
- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self rain_preferredInterfaceOrientationForPresentation];
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
