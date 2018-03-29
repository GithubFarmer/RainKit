//
//  RainPhotoRecycle.m
//  RainKit
//
//  Created by 喻永权 on 2018/3/8.
//

#import "RainPhotoRecycle.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RainPhotoRecycle()<UIScrollViewDelegate>

/**
 滑动视图
 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**
 指示器
 */
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 左边视图
 */
@property (nonatomic, strong) UIImageView *leftImageView;

/**
 中间视图
 */
@property (nonatomic, strong) UIImageView *centerImageView;

/**
 右边视图
 */
@property (nonatomic, strong) UIImageView *rightImageView;

/**
 当前页数
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 定时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RainPhotoRecycle

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)urls intervalTime:(NSTimeInterval)time{
    self = [super initWithFrame:frame];
    if(self){
        self.imageUrls = urls;
        self.intervalTime = time;
        self.currentPage = 0;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self setUpTimer];
    [self setUpImageViews];
}

- (void)setUpImageViews{
    
    CGFloat WIDTH = self.frame.size.width;
    CGFloat HEIGHT = self.frame.size.height;
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2*WIDTH, 0, WIDTH, HEIGHT)];
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.centerImageView];
    [self.scrollView addSubview:self.rightImageView];
    
    [self.leftImageView sd_setImageWithURL:[self getImageUrlBeforeIndex:self.currentPage]];
    [self.centerImageView sd_setImageWithURL:[self getImageUrlAtIndex:self.currentPage]];
    [self.rightImageView sd_setImageWithURL:[self getImageUrlAfterIndex:self.currentPage]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerImageAction)];
    self.centerImageView.userInteractionEnabled = YES;
    [self.centerImageView addGestureRecognizer:tap];
}

- (void)centerImageAction{
    if([self.delegate respondsToSelector:@selector(RainPhotoRecycle:selectedAtIndex:)]){
        [self.delegate RainPhotoRecycle:self selectedAtIndex:self.currentPage];
    }
    
}

- (void)timeRepateAction{
    self.currentPage++;
    if(self.currentPage == self.imageUrls.count){
        self.currentPage = 0;
    }
    [UIView animateWithDuration:1 animations:^{
       
        self.centerImageView.userInteractionEnabled = NO;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame)*2, 0);
    }completion:^(BOOL finished) {
        
        self.centerImageView.userInteractionEnabled = YES;
        self.leftImageView.image = self.centerImageView.image;
        self.centerImageView.image = self.rightImageView.image;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        [self.leftImageView sd_setImageWithURL:[self getImageUrlAfterIndex:self.currentPage]];
        self.pageControl.currentPage = self.currentPage;
    }];
}

- (void)setUpTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.intervalTime target:self selector:@selector(timeRepateAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (NSURL *)getImageUrlBeforeIndex:(NSInteger)index{
    
    NSString *url = nil;
    if(index == 0){
        url = [self.imageUrls lastObject];
    }else{
        url = self.imageUrls[index - 1];
    }
    return [NSURL URLWithString:url];
}

- (NSURL *)getImageUrlAtIndex:(NSInteger)index{
    NSString *url = self.imageUrls[index];
    return [NSURL URLWithString:url];
}

- (NSURL *)getImageUrlAfterIndex:(NSInteger)index{
    NSString *url = nil;
    if(index == self.imageUrls.count - 1){
        url = [self.imageUrls firstObject];
    }else{
        url = self.imageUrls[index + 1];
    }
    return [NSURL URLWithString:url];
}

- (UIScrollView *)scrollView{
    if(_scrollView == nil){
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * 3, CGRectGetHeight(self.frame));
        _scrollView.contentInset = UIEdgeInsetsZero;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.decelerationRate = 1.0;
        _scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    if(_pageControl == nil){
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width/2 -50, self.frame.size.height - 35, 100, 30)];
        _pageControl.numberOfPages = self.imageUrls.count;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setUpTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if(index == 0){
        self.currentPage--;
        if(self.currentPage < 0){
            self.currentPage = self.imageUrls.count;
        }
        self.rightImageView.image = self.centerImageView.image;
        self.centerImageView.image = self.leftImageView.image;
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        [self.leftImageView sd_setImageWithURL:[self getImageUrlBeforeIndex:self.currentPage]];
        self.pageControl.currentPage = self.currentPage;
    }else if (index == 2){
        self.currentPage++;
        if(self.currentPage == self.imageUrls.count){
            self.currentPage = 0;
        }
        self.leftImageView.image = self.centerImageView.image;
        self.centerImageView.image = self.rightImageView.image;
        scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        [self.leftImageView sd_setImageWithURL:[self getImageUrlAfterIndex:self.currentPage]];
        self.pageControl.currentPage = self.currentPage;
    }
}
@end
