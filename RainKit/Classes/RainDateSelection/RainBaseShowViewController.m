//
//  RainBaseShowViewController.m
//  RainKit
//
//  Created by 喻永权 on 2018/5/2.
//

#import "RainBaseShowViewController.h"

@interface RainBaseShowViewController ()

@end

@implementation RainBaseShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showViewController:(UIViewController *)vc{
    [vc presentViewController:self animated:NO completion:nil];
}

- (void)dismissController{
    [self dismissViewControllerAnimated:NO completion:nil];
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
