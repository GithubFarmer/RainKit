//
//  RainPhotoRecycle.h
//  RainKit
//
//  Created by 喻永权 on 2018/3/8.
//

#import <UIKit/UIKit.h>

@class RainPhotoRecycle;

@protocol RainPhotoRecycleDelegate <NSObject>

- (void)RainPhotoRecycle:(RainPhotoRecycle *)photoRecycle selectedAtIndex:(NSInteger)index;

@end

/**
 封装一个图片轮播器
 */
@interface RainPhotoRecycle : UIView

@property (nonatomic, copy) NSArray <NSString *> *imageUrls;
@property (nonatomic, assign) NSTimeInterval intervalTime;

@property (nonatomic, weak) id<RainPhotoRecycleDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)urls intervalTime:(NSTimeInterval)time;

@end


