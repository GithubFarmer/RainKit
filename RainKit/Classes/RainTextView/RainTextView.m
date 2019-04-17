//
//  RainTextView.m
//  RainKit
//
//  Created by 喻永权 on 2019/3/28.
//

#import "RainTextView.h"
#import "RainHeader.h"

@interface RainTextView()<UITextViewDelegate>

@property(nonatomic,strong)UILabel *textLabel;

@end

@implementation RainTextView

+(instancetype)textView
{
    return [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initView];
        self.delegate = self;
    }
    return self;
}

- (void)initView
{
    self.textLabel            = [[UILabel alloc]initWithFrame:CGRectMake(10 * kSCALL, 0 * kSCALL, 300 * kSCALL, 30 * kSCALL)];
    self.textLabel.textColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    self.textLabel.font       = self.font;
    self.textLabel.text       = @"placeholder";
    [self addSubview:self.textLabel];
    
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    if (self.text.length == 0)
    {
        self.textLabel.hidden = NO;
    }
    else
    {
        self.textLabel.hidden = YES;
    }
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.textLabel.font = font;
    self.textLabel.frame = CGRectMake(10 * kSCALL, 0 * kSCALL, 300 * kSCALL, (font.pointSize + 17) * kSCALL);
}
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.textLabel.text = placeholder;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length == 0 && textView.text.length == 1)
    {
        self.textLabel.hidden = NO;
        return YES;
    }
    if (text.length == 0 && textView.text.length == 0)
    {
        self.textLabel.hidden = NO;
        return YES;
    }
    self.textLabel.hidden = YES;
    return YES;
}


@end
