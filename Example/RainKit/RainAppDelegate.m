//
//  RainAppDelegate.m
//  RainKit
//
//  Created by 喻永权 on 02/28/2018.
//  Copyright (c) 2018 喻永权. All rights reserved.
//

#import "RainAppDelegate.h"
#import "RainViewController.h"
#import "RainCenterViewController.h"
#import "RainLeftViewController.h"
#import <MMDrawerController/MMDrawerController.h>
@implementation RainAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
   
    
//    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:[RainViewController new]];
//    self.window.rootViewController  = nvc;
    [self setUpRootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)setUpRootViewController{
    
    RainCenterViewController *centerVC = [RainCenterViewController new];
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:centerVC];
    
    RainLeftViewController *leftVC = [RainLeftViewController new];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:leftVC];

    UITabBarController *tabbarVC = [[UITabBarController alloc]init];
    tabbarVC.viewControllers = @[nvc1,nvc2];
    
    MMDrawerController *drawVC = [[MMDrawerController alloc]initWithCenterViewController:centerVC leftDrawerViewController:leftVC];
    
    [drawVC setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        
    }];
    
    self.window.rootViewController = drawVC;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
