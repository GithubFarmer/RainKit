//
//  RainAnnimation_Five_ViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/11/28.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainAnnimation_Five_ViewController.h"
#import <RainKit/RainHeader.h>
#import "UIScrollView+RainGestureConflict.h"

@interface RainAnnimation_Five_ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation RainAnnimation_Five_ViewController{
    UIScrollView * scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"全屏侧滑返回";
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight)];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    //默认值为YES 表示延迟scrollView上子视图的响应，所以当直接拖动UISlider时，如果此时touch时间在150ms以内，UIScrollView会认为是拖动自己，从而拦截了event，导致UISlider接受不到滑动的event。但是只要长按住UISlider一会儿再拖动，此时touch时间超过150ms，因此滑动的event会发送到UISlider上，然后UISlider再作出响应；设置为NO后，拖动UISlider时就可以直接做出响应，解决了UISlider和UIScrollView的冲突。
    //方案一：解决了UISlider和UIScrollView的冲突
    scrollView.delaysContentTouches = NO;
    for (int i = 0; i < 3; i++) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollView.frame.size.height)];
        view.backgroundColor = RGBRANDOMCOLOR;
        [scrollView addSubview:view];
        
        //滑块视图
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 100)];
        label.center = CGPointMake(SCREEN_WIDTH/2.0, view.frame.size.height/2.0 - 100);
        label.text = i == 0 ? @"全屏侧滑返回、UISlider、UIScrollView相互间的手势冲突" : @"UISlider和UIScrollView的滑动事件冲突";
        label.textColor = RGBRANDOMCOLOR;
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor whiteColor];
        [view addSubview:label];
        
        UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(20, label.frame.origin.y + 200, SCREEN_WIDTH - 40, 50)];
        slider.minimumTrackTintColor = RGBRANDOMCOLOR;
        slider.maximumTrackTintColor = RGBRANDOMCOLOR;
        [view addSubview:slider];
        
    }
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height);
    [self.view addSubview:scrollView];
    
    
    //获取系统自带滑动手势的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    //创建全屏滑动手势，调用系统自带滑动手势的target的action方法
     SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    //设置手势代理，拦截手势触发
    pan.delegate = self;
    //给导航控制期的view添加全屏滑动手势
    [self.navigationController.view addGestureRecognizer:pan];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //禁止使用系自带的pop滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.delegate = nil;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if(self.navigationController.viewControllers.count == 1){
        return NO;
    }else if([gestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")] && scrollView.contentOffset.x != 0){
        return NO;
    }else{
        return YES;
    }
}

- (void)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
