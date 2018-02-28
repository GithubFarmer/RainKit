//
//  RainPictureBlurManager.m
//  RainKit
//
//  Created by 喻永权 on 2018/2/28.
//

#import "RainPictureBlurManager.h"

@implementation RainPictureBlurManager

- (double)getImgBlurDegreeValue:(UIImage *)sourceImage{
    if(!sourceImage){
        return  0;
    }
    UIImage *grayScale = [self getGaryScale:sourceImage];
    CGImageRef imageRef = [grayScale CGImage];
    CGFloat width = CGImageGetWidth(imageRef);
    CGFloat height = CGImageGetHeight(imageRef);
    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    NSData *data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    uint8_t *graescaleData = (uint8_t *)[data bytes];
    NSLog(@"模糊度数值：%f",getImgBlurDegree(graescaleData, width, height));
    return getImgBlurDegree(graescaleData, width, height);
}

//获取灰度图
- (UIImage *)getGaryScale:(UIImage *)sourceImage{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, width, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if(context == NULL){
        return nil;
    }
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

// 计算模糊程度（小于500认为是模糊图，这个值可以自己看情况定义）
double getImgBlurDegree(unsigned char* ImgDateGray, int nWidth, int nHeight){
    if(ImgDateGray == NULL || nWidth <= 4 || nHeight <= 4){
        return 0.0;
    }
    int row = nHeight;
    int col = nWidth;
    int widthstep = nWidth;
    double S =0;
    unsigned char * data = ImgDateGray;
    for(int x = 1 ; x < row - 1; x+=2){
        unsigned char *pre_row=data +(x-1)*widthstep;
        unsigned char *cur_row=data +x*widthstep;
        unsigned char *nex_row=data +(x+1)*widthstep;
        int Sx,Sy;
        for(int y = 1;y<col-1;y+=2)
        {
            Sx=(int)pre_row[y+1]+2*(int)cur_row[y+1]+(int)nex_row[y+1]//一定要转为uchar
            -(int)pre_row[y-1]-2*(int)cur_row[y-1]-(int)nex_row[y-1];
            Sy=(int)nex_row[y-1]+2*(int)nex_row[y]+(int)nex_row[y+1]
            -(int)pre_row[y-1]-2*(int)pre_row[y]-(int)pre_row[y+1];
            S+=Sx*Sx+Sy*Sy;
        }
    }
    return S/(row/2-2)/(col/2-2);
}
@end
