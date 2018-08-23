//
//  RainLoginView.m
//  RainKit_Example
//
//  Created by 喻永权 on 2018/8/22.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "RainLoginView.h"
#import <Masonry/Masonry.h>

@interface RainLoginView ()

@property (nonatomic,strong) UITextField *phoneField;
@property (nonatomic,strong) UITextField *passwordField;

@property (nonatomic,strong) UILabel *vCodeLab;
@property (nonatomic,strong) UIButton *vCodeBtn;
@end

@implementation RainLoginView
{
    UIButton *rightBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initLogin];
    }
    return self;
}

-(void)initLogin{
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"登录";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:20];
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(32);
    }];
    
    _phoneField = [[UITextField alloc] init];
    _phoneField.placeholder = @"手机号码";
    _phoneField.keyboardType = UIKeyboardTypePhonePad;
    _phoneField.font = [UIFont systemFontOfSize:16];
    [self addSubview:_phoneField];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(titleLab.mas_bottom).offset(52);
        make.height.offset(32);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(94);
        make.left.right.offset(0);
        make.height.offset(.5);
    }];
    
    _passwordField = [[UITextField alloc] init];
    _passwordField.placeholder = @"登录密码";
    _passwordField.keyboardType = UIKeyboardTypeNumberPad;
    _passwordField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordField.font = [UIFont systemFontOfSize:16];
    [_passwordField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_passwordField];
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).with.offset(20);
        make.left.height.equalTo(self.phoneField);
        make.right.equalTo(self).with.offset(-28);
    }];
    
    _vCodeLab = [[UILabel alloc] init];
    _vCodeLab.text = @"验证码";
    _vCodeLab.hidden = YES;
    _vCodeLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:_vCodeLab];
    [_vCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).with.offset(20);
        make.left.height.equalTo(self.phoneField);
        make.width.offset(49);
    }];
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 10));
        make.top.equalTo(self.passwordField).with.offset(12);
    }];
    
    _vCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_vCodeBtn setTitle:@"获取验证码" forState:0];
    _vCodeBtn.hidden = YES;
    [_vCodeBtn setTitleColor:[UIColor greenColor] forState:0];
    _vCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_vCodeBtn];
    [_vCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).with.offset(20);
        make.height.equalTo(self.phoneField);
        make.right.offset(0);
        make.width.offset(82);
    }];
    
    
    UIView *lastView = [[UIView alloc] init];
    lastView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lastView];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(157);
        make.left.right.offset(0);
        make.height.offset(.5);
    }];
    
    UIButton *verificatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verificatBtn setTitle:@"验证码登录" forState:0];
    [verificatBtn setTitle:@"密码登录" forState:UIControlStateSelected];
    [verificatBtn setTitleColor:[UIColor greenColor] forState:0];
    verificatBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [verificatBtn addTarget:self action:@selector(verificatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:verificatBtn];
    [verificatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(82, 22));
        make.left.offset(0);
    }];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor = [UIColor redColor];
    _loginBtn.userInteractionEnabled = NO;
    [_loginBtn setTitle:@"登录" forState:0];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    _loginBtn.layer.cornerRadius = 4;
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verificatBtn.mas_bottom).with.offset(20);
        make.left.right.offset(0);
        make.height.offset(50);
    }];
    
    UILabel *warnLabel = [[UILabel alloc] init];
    warnLabel.text = @"未注册手机号将自动注册";
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.textColor =[UIColor yellowColor];
    warnLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:warnLabel];
    [warnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).with.offset(14);
        make.left.right.offset(0);
        make.height.offset(22);
    }];
}

-(void)textFieldTextChange:(UITextField *)textField{
    NSString *fieldStr = textField.text;
    NSLog(@"%@",fieldStr);
    if (fieldStr.length == 0) {
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = [UIColor redColor];
    }else{
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = [UIColor greenColor];
    }
}

//验证码登录
-(void)verificatBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    _vCodeLab.hidden = !btn.selected;
    _vCodeBtn.hidden = !btn.selected;
    rightBtn.hidden = btn.selected;
    if (btn.selected) {
        _passwordField.placeholder = @"请输入验证码";
        [_passwordField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(54);
            make.right.offset(-92);
        }];
    }else{
        _passwordField.placeholder = @"登录密码";
        [_passwordField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.equalTo(self).with.offset(-28);
        }];
    }
    [_passwordField.superview layoutIfNeeded];
}

-(void)rightBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        _passwordField.secureTextEntry = YES;
    }else{
        _passwordField.secureTextEntry = NO;
    }
}

//登陆
-(void)loginBtnAction{
    [self endEditing:YES];
//    UserInfo *info = [[UserInfo alloc] initWithContentDic:@{@"token":@"1234567890"}];
//    [UserInfo setTheUserInfo:info];
//    [[NSNotificationCenter defaultCenter] postNotificationName:LoginSuccess object:nil];
//    [self.viewController dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}

//获取验证码
-(void)vercodeAction{
    
    
}

@end

