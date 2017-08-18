//
//  MainViewController.m
//  AvatarPullViewController
//
//  Created by 李蛋伯 on 2017/6/16.
//  Copyright © 2017年 李蛋伯. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"


@interface MainViewController ()


@property (nonatomic, strong) UIButton *btn;


@end


@implementation MainViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"主页";
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.btn]; // 注意：此处切记勿用下划线表示对象，以免所添加子视图无法显示！
}


#pragma mark -- button method
// 懒加载按钮
- (UIButton *)btn{
    
    if (!_btn) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor orangeColor];
        _btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 200)/2, ([UIScreen mainScreen].bounds.size.height - 200)/2, 200.f, 200.0f);
        [_btn setTitle:@"可拉伸头部控件" forState:UIControlStateNormal];
        _btn.tintColor = [UIColor whiteColor];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn;
}


#pragma mark -- event response
// 按钮事件
- (void)btnAction{
    
    ViewController *view = [[ViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
