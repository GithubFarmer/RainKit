//
//  RainTextView.h
//  RainKit
//
//  Created by 喻永权 on 2019/3/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RainTextView : UITextView

@property(nonatomic,copy)NSString *placeholder;

/**
 *  构建方法
 */
+ (instancetype)textView ;

@end

NS_ASSUME_NONNULL_END
