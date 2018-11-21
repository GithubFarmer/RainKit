//
//  RainMasonryViewController.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/5/18.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainMasonryViewController.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIKit+AFNetworking.h>

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
    
    [self barrier];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 120, 200, 200)];
    [self.view addSubview:btn];
    NSURL *url = [NSURL URLWithString:@"https://wwwarehouse.oss-cn-hangzhou.aliyuncs.com/cit/avatar/80b926754aeb4468b4b5cdeb997de5f9.jpeg"];
    [btn setImageForState:UIControlStateNormal withURL:url];
//    [btn setImageForState:UIControlStateNormal withURL:url placeholderImage:[UIImage imageNamed:@"px_blue"]];
    
    
    
    
    
    
    
    
    NSArray *dateUnits = @[@"年",@"月",@"日"];
    UILabel *temp1;
    for(int i = 0; i < 3; i ++){
        UILabel *dateLabel = [UILabel new];
        dateLabel.text = @"2015";
        dateLabel.textAlignment = NSTextAlignmentCenter;
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor redColor];
        UILabel *unitLabel = [UILabel new];
        unitLabel.text = dateUnits[i];
        [self.view addSubview:dateLabel];
        [self.view addSubview:lineView];
        [self.view addSubview:unitLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                make.left.equalTo(self.view);
            }else{
                make.left.equalTo(temp1.mas_right).offset(8);
            }
            make.top.equalTo(self.view).offset(350);
            make.height.mas_equalTo(16);
            make.width.equalTo(lineView);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                make.left.equalTo(@0);
            }else{
                make.left.equalTo(temp1.mas_right).offset(8);
            }
            make.top.equalTo(dateLabel.mas_bottom).offset(5);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(0.5);
        }];
        [unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0){
                make.left.equalTo(lineView.mas_right).offset(8);
            }else{
                make.left.equalTo(temp1.mas_right).offset(86);
            }
            make.bottom.equalTo(lineView);
        }];
        temp1 = unitLabel;
    }
    
    
    
    
    
    
}

- (void)barrier
{
    　//同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
    dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
    [self async];
}

- (void)sync{
    dispatch_queue_t queue1 = dispatch_queue_create("dispatchGroupMethod1.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-同步任务执行-:%ld",@"任务1",(long)i);
                
            }
        });
    });
    
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_sync(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-同步任务执行-:%ld",@"任务2",(long)i);
                
            }
        });
    });
    
    //    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
        dispatch_group_wait(group1, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
    dispatch_group_notify(group1, queue1, ^{
        NSLog(@"Method1-全部任务执行完成");
    });
}

- (void)async{
    dispatch_queue_t queue1 = dispatch_queue_create("dispatchGroupMethod1.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group1 = dispatch_group_create();
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_async(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-异步任务执行-:%ld",@"任务1",(long)i);
                
            }
        });
    });
    
    
    dispatch_group_async(group1, queue1, ^{
        dispatch_async(queue1, ^{
            for (NSInteger i =0; i<3; i++) {
                sleep(1);
                NSLog(@"%@-异步任务执行-:%ld",@"任务2",(long)i);
                
            }
        });
    });
    
    //    //等待上面的任务全部完成后，会往下继续执行 （会阻塞当前线程）
    //    dispatch_group_wait(group1, DISPATCH_TIME_FOREVER);
    
    //等待上面的任务全部完成后，会收到通知执行block中的代码 （不会阻塞线程）
    dispatch_group_notify(group1, queue1, ^{
        NSLog(@"Method1-全部任务执行完成");
    });
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
