//
//  ViewController.m
//  AvatarPullViewController
//
//  Created by 李蛋伯 on 2017/6/16.
//  Copyright © 2017年 李蛋伯. All rights reserved.
//

#import "ViewController.h"
#import "CustomNavigationBar.h"

@interface ViewController (){
    
    CustomNavigationBar *navBar;
    UIImageView *bgView;
    CGRect originalFrame;
}

@end


@implementation ViewController


static const CGFloat ratio = 0.8f;      //背景图片的高宽比
static const CGFloat headHeight = 160.0f;
#define GREENCOLOR  [UIColor colorWithRed:87/255.0 green:173/255.0 blue:104/255.0 alpha:1]


//视图预加载方法
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated]; //隐藏视图的导航栏
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO; //视图控制器是否自动调整其滚动视图的插入。
    
    //背景图片
    bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, ratio * self.view.frame.size.width)];
    bgView.image = [UIImage imageNamed:@"bg-mine.png"];
    originalFrame = bgView.frame;   //储存bgView.frame的初始值，在后续效果中使用
    [self.view addSubview:bgView];
    
    //表视图
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 64.0f, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 64.f) style:UITableViewStylePlain];
    table.backgroundColor = [UIColor clearColor]; //背景颜色设为透明。
    table.showsVerticalScrollIndicator = NO; //不显示垂直滚动指示器（即滚动条儿）
    table.delegate = self;
    table.dataSource = self;
    //头视图
    //弃用设置contentInset而选择建立头视图headView来实现表视图上方背景图片显示的原因：为了方便后续滚动效果的编写，contentInset的偏移量contentOffset初始位置需设为（0，-160）；而头视图的偏移量contentOffset初始位置可以直接为（0, 0），计算起来较方便。
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, headHeight)];
    //headView.backgroundColor = [UIColor clearColor]; //表视图的背景颜色与其头视图的一致。
    table.tableHeaderView = headView;
    [self.view addSubview:table];
    
    //导航栏
    navBar = [[CustomNavigationBar alloc]init];
    navBar.title = @"可拉伸头部控件";
    navBar.leftBtnImage = @"Mail.png";
    navBar.rightBtnImage = @"Setting.png";
    navBar.titleColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    
    
}


#pragma mard -- UITableViewDelegate && UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellIdentifier"];
    }
    cell.textLabel.text = @"Test";
    
    return cell;
}


#pragma mark -- scroll action
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat yOffset = scrollView.contentOffset.y; //往上滑动偏移量offset增加，往下滑动偏移量offset减少。
    
    // 实现导航栏渐变
    if (yOffset < headHeight) {     //表视图顶端滑动到导航栏底部前
        
        CGFloat colorAlpha = yOffset / headHeight; //导航栏随着偏移量的增加而变得不透明
        navBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:colorAlpha];
        // 重置导航栏控件属性
        navBar.leftBtnImage = @"Mail";
        navBar.rightBtnImage = @"Setting";
        navBar.titleColor = [UIColor whiteColor];
    }else{      //表视图顶部滑动到导航栏底部后
        
        navBar.backgroundColor = [UIColor whiteColor];
        // 重置导航栏控件属性
        navBar.leftBtnImage = @"Mail-click.png";
        navBar.rightBtnImage = @"Setting-click.png";
        navBar.titleColor = GREENCOLOR; //宏定义颜色
    }
    
    
    // 实现背景图往上移动、下滑放大效果（缩放的概念，即改变宽高）
    if (yOffset > 0) {      //往上移动
        
        // 只要将一个view进行位置移动或者形变，一般都是改变其frame
        bgView.frame = ({       //复合语句，优点：增加代码可阅读性。
            
            //CGRect frame = bgView.frame;  //此处不能使用bgView.frame，它是随时改变的，且改变的值为yOffset的累加值。
            CGRect frame = originalFrame;   //使用bgView.frame的初始值
            frame.origin.y = originalFrame.origin.y - yOffset;  //背景图y坐标随偏移量增加而减少
            
            frame;
        });
    }else{      //往下移动，此时偏移量yOffset为负数
        
        bgView.frame = ({
        
            CGRect frame = originalFrame;
            frame.size.height = originalFrame.size.height - yOffset;    //背景图拉伸范围随偏移量增加而增加。由于下拉时yOffset为负，所以这里用减号。
            frame.size.width = frame.size.height / ratio;     //使背景图高宽比在拉伸过程中保持不变
            frame.origin.x = originalFrame.origin.x - (frame.size.width - originalFrame.size.width)/2;      //将背景图的x轴原点坐标左移,以保持背景图中心无偏移
            NSLog(@"%f", frame.origin.x);
            frame;
        });
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
