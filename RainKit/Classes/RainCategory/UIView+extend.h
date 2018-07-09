//
//  UIView+extend.h
//  Pods
//
//  Created by 喻永权 on 2018/4/23.
//

typedef NS_OPTIONS(NSUInteger, RainRectCorner){
    RainRectCornerLeftTop      = 1 << 0,
    RainRectCornerRightTop     = 1 << 1,
    RainRectCornerLeftBottom   = 1 << 2,
    RainRectCornerRightBottom  = 1 << 3,
    RainRectCornerAll          = ~0UL
};

@interface UIView (extend)


/**
 给view加圆角

 @param corners 圆角的位置
 @param size 圆角的大小
 */
- (void)addCorner:(RainRectCorner)corners cornerRadius:(CGSize)size;

/**
 view是否存在第一响应

 @return 存在为YES，反之为NO
 */
- (BOOL)isExistFirstResponder;


/**
 给view截图

 @return 截图image
 */
- (UIImage *)imageCutScreen;



/**
 指定一个view，对其进行旋转操作
 */
- (void)startRotation;



/**
 给指定的view添加边线

 @param lineColor 线条颜色
 @param lineWidth 线条宽度
 */
- (void)addLine:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth;


/**
 给指定的view添加虚线边框

 @param dashLineColor 虚线颜色
 @param lineWidth 虚线宽度
 @param size 圆角 
 */
- (void)addDashLine:(UIColor *)dashLineColor lineWidth:(CGFloat)lineWidth cornerRad:(CGFloat)rad;

@end
