//
//  CustomNavigationBar.m
//  AvatarPullViewController
//
//  Created by 李蛋伯 on 2017/6/16.
//  Copyright © 2017年 李蛋伯. All rights reserved.
//

#import "CustomNavigationBar.h"


@interface CustomNavigationBar ()


@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *titleLabel;


@end


@implementation CustomNavigationBar


- (instancetype)init{
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0.0f, 0.0f, [[UIScreen mainScreen]bounds].size.width, 64.0f);
    }
    
    return self;
}


// 重写setter方法。优点：方便属性扩展，增加其功能，以及在外部接口不变的情况下，修改内部储存方式和逻辑等，优点相当多。
- (void)setTitle:(NSString *)title{
    
    _title = title; //该方法为getter方法本身，此处不能使用self. 写法，否则会造成循环引用。
    self.titleLabel.text = _title;
}

- (void)setTitleColor:(UIColor *)titleColor{
    
    _titleColor = titleColor;
    self.titleLabel.textColor = _titleColor;
}

- (void)setLeftBtnImage:(NSString *)leftBtnImage{
    
    _leftBtnImage = leftBtnImage;
    [self.leftBtn setBackgroundImage:[UIImage imageNamed:_leftBtnImage] forState:UIControlStateNormal];
    // 使用setBackgroundImage而不使用setImage的优势：图片会随着按钮的大小而改变，图片自动会拉伸来适应按钮的大小，这个时候任然可以设置按钮的title，图片不会挡住title。
}

- (void)setRightBtnImage:(NSString *)rightBtnImage{
    
    _rightBtnImage = rightBtnImage;
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:_rightBtnImage] forState:UIControlStateNormal];
}


// 懒加载getter方法。懒加载优点：对象的实例化在getter方法中，各司其职，降低耦合性；对系统的内存占用率会减小。
- (UIButton *)leftBtn{
    
    if (!_leftBtn) {
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(15.0f, 32.0f, 22.0f, 16.0f);
    }
    
    return _leftBtn;
}

- (UIButton *)rightBtn{

    if (!_rightBtn) {
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.frame.size.width - 37.0f, 30.0f, 22.0f, 22.0f);
    }
    
    return _rightBtn;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter; // 标签文本居中
        _titleLabel.center = CGPointMake(self.frame.size.width/2, (self.frame.size.height + 20.0f)/2); //中心点坐标
        _titleLabel.bounds = CGRectMake(0.0f, 0.0f, 200.0f, self.frame.size.height - 20.0f); //相对于标题栏自身的坐标、尺寸
    }
    
    return _titleLabel; //该方法为getter方法本身，此处不能使用self. 写法，否则会造成循环引用。
}

- (void)layoutSubviews{
    
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.titleLabel];
    // 注意：此处勿用下划线写法，以免所添加子视图无法显示！
}

@end

