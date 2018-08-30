//
//  RainCircleView.h
//  RainKit
//
//  Created by 喻永权 on 2018/8/30.
//

#import <UIKit/UIKit.h>

/**
 圆环
 */
@protocol RainCircleViewDataSource;

@interface RainCircleView : UIView

- (void)reloadCircleView;

@property (nonatomic, assign) BOOL isAnimation;

@property (nonatomic, weak) id <RainCircleViewDataSource> dataSource;

@end

@protocol RainCircleViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemInCircleView:(RainCircleView *)circleView;

- (NSNumber *)ratioOfItemInCircleView:(RainCircleView *)circleView itemAtIndex:(NSInteger)index;

- (UIColor *)colorOfItemInCircleView:(RainCircleView *)circleView itemAtIndex:(NSInteger)index;

@optional
- (void)circleView:(RainCircleView *)circleView selectedItemAtIndex:(NSInteger)index;

@end
