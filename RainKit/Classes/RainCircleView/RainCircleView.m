//
//  RainCircleView.m
//  RainKit
//
//  Created by 喻永权 on 2018/8/30.
//

#import "RainCircleView.h"

static CGFloat const LINE_WIDTH = 40.f;

@interface RainCircleView ()

@property (nonatomic, assign) CGFloat lindWidth;

@property (nonatomic, assign) NSInteger numberOfItem;

@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;

@property (nonatomic, strong) NSMutableArray *ratioArray;

@property (nonatomic, assign) CGFloat totalRatio;

@property (nonatomic, strong) NSMutableArray *layerArray;

@end


@implementation RainCircleView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.lindWidth = LINE_WIDTH;
        _isAnimation = YES;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(!_numberOfItem){
        [self reloadCircleView];
    }
}

- (void)reloadCircleView{
    _numberOfItem = 0;
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [_colorArray removeAllObjects];
    [_ratioArray removeAllObjects];
    [_layerArray removeAllObjects];
    _ratioArray = nil;
    _colorArray = nil;
    //view的中心点
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat Height = CGRectGetHeight(self.frame);
    CGPoint center = CGPointMake(width/2, Height/2);
    //渲染半径
    CGFloat radius = (width > Height ? Height : width)/2 - self.lindWidth/2;
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    for(int i = 0; i < self.numberOfItem; i++){
       
        //结束比例
        endAngle = [self.ratioArray[i] floatValue] / self.totalRatio;
        UIBezierPath *berzier = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle*2*M_PI endAngle:(startAngle + endAngle)*2*M_PI clockwise:YES];
        CAShapeLayer *shapeLayer = [CAShapeLayer new];
        shapeLayer.path = berzier.CGPath;
        shapeLayer.lineWidth = self.lindWidth;
        shapeLayer.strokeColor = self.colorArray[i].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:shapeLayer];
        if(_isAnimation){
            CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
            anima.duration = 0.15f;
            anima.fromValue = @0;
            anima.toValue = @1;
            [shapeLayer addAnimation:anima forKey:@"strokeStart"];
        }
        
        [self.layerArray addObject:shapeLayer];
        //开始比例
        startAngle += endAngle;
    }
}

- (NSInteger)numberOfItem{
    if(!_numberOfItem){
        _numberOfItem = [self.dataSource numberOfItemInCircleView:self];
    }
    return _numberOfItem;
}

- (NSMutableArray<UIColor *> *)colorArray{
    if(!_colorArray){
        _colorArray = [NSMutableArray new];
        for (int i = 0; i < self.numberOfItem; i++) {
            UIColor *color = [self.dataSource colorOfItemInCircleView:self itemAtIndex:i];
            [_colorArray addObject:color];
        }
    }
    return _colorArray;
}

- (NSMutableArray *)ratioArray{
    if(!_ratioArray){
        _ratioArray = [NSMutableArray new];
        _totalRatio = 0;
        for(int i = 0; i < self.numberOfItem; i++){
            NSNumber *ratio = [self.dataSource ratioOfItemInCircleView:self itemAtIndex:i];
            [_ratioArray addObject:ratio];
            _totalRatio += [ratio floatValue];
        }
    }
    return _ratioArray;
}

- (NSMutableArray *)layerArray{
    if(_layerArray == nil){
        _layerArray = [NSMutableArray new];
    }
    return _layerArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@",touches);
    
//    touches.count
    CGPoint pointInView = [[[touches objectEnumerator].allObjects firstObject] locationInView:self];
//    CGPoint pointInView = [[touches anyObject] locationInView:self];
    __block  CAShapeLayer *layer = [self.layer hitTest:pointInView];
    [_layerArray enumerateObjectsUsingBlock:^(CALayer *obj, NSUInteger idx, BOOL * _Nonnull stop) {


            if([self.dataSource respondsToSelector:@selector(circleView:selectedItemAtIndex:)]){
                [self.dataSource circleView:self selectedItemAtIndex:idx];
            }
            *stop = YES;

    }];
}


//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//
//    CALayer *layer = [self.layer hitTest:point];
//    [_layerArray enumerateObjectsUsingBlock:^(CAShapeLayer *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if(layer == obj){
//            if([self.dataSource respondsToSelector:@selector(circleView:selectedItemAtIndex:)]){
//                [self.dataSource circleView:self selectedItemAtIndex:idx];
//            }
//            *stop = YES;
//        }
//    }];
//    return YES;
//}
@end
