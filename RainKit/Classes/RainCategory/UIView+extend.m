//
//  UIView+extend.m
//  Pods
//
//  Created by 喻永权 on 2018/4/23.
//

#import "UIView+extend.h"
#import <objc/runtime.h>

static char const *KLineLayer = "Rain.lineLayer";

static char const *KDashLineLayer = "Rain.dashLineLayer";

@interface UIView ()

@property (nonatomic, strong) CAShapeLayer *dashBorderLayer;

@property (nonatomic, strong) CAShapeLayer *borderLayer;

@end

@implementation UIView (extend)


- (void)addCorner:(RainRectCorner)corners cornerRadius:(CGSize)size{
    
    UIBezierPath *beziber = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCorner)corners cornerRadii:size];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = beziber.CGPath;
    maskLayer.frame = self.bounds;
    self.layer.mask = maskLayer;
}

- (BOOL)isExistFirstResponder{
    
    if(self.isFirstResponder){
        return YES;
    }
    for(UIView *subView in self.subviews){
        if(subView.isFirstResponder){
            return YES;
        }
    }
    return NO;
}

- (UIImage *)imageCutScreen{
    
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}

- (void)addLine:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth{
    
    if(self.borderLayer == nil){
        
        self.borderLayer = [CAShapeLayer layer];
        self.borderLayer.lineWidth = lineWidth;
        self.borderLayer.fillColor = [UIColor clearColor].CGColor;
        self.borderLayer.strokeColor = lineColor.CGColor;
        [self.layer addSublayer:self.borderLayer];
    }
    self.borderLayer.frame = self.bounds;
    self.borderLayer.path = [UIBezierPath bezierPathWithRect:self.borderLayer.bounds].CGPath;
}


- (void)addDashLine:(UIColor *)dashLineColor lineWidth:(CGFloat)lineWidth cornerRad:(CGFloat)rad{
    
    if(self.dashBorderLayer == nil){
        
        self.dashBorderLayer = [CAShapeLayer layer];
        self.dashBorderLayer.lineWidth = lineWidth;
        self.dashBorderLayer.lineDashPattern = @[@4,@4];
        self.dashBorderLayer.fillColor = [UIColor clearColor].CGColor;
        self.dashBorderLayer.strokeColor = dashLineColor.CGColor;
        [self.layer addSublayer:self.dashBorderLayer];
    }
    self.dashBorderLayer.frame = self.bounds;
    self.dashBorderLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.dashBorderLayer.bounds
                                                           cornerRadius:rad].CGPath;
}

- (void)startRotation{
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    animation.duration = 2.5;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:animation forKey:@"rotation"];
}

- (void)setDashBorderLayer:(CAShapeLayer *)dashBorderLayer{
    objc_setAssociatedObject(self, KDashLineLayer, dashBorderLayer, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)dashBorderLayer{
    return objc_getAssociatedObject(self, KDashLineLayer);
}

- (void)setBorderLayer:(CAShapeLayer *)borderLayer{
    objc_setAssociatedObject(self, KLineLayer, borderLayer, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)borderLayer{
    return objc_getAssociatedObject(self, KLineLayer);
}
@end
