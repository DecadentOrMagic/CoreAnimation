//
//  ViewController.m
//  Part3
//
//  Created by 薛尧 on 16/8/30.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic, assign) int index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  转场动画简单介绍
     *  CAAnimation的子类，用于做转场动画，能够为层提供移出屏幕和移入屏幕的动画效果。iOS比Mac OS X的转场动画效果少一点
     *  UINavigationController就是通过CATransition实现了将控制器的视图推入屏幕的动画效果
     *
     *  属性解析:
     *  type：动画过渡类型
     *  subtype：动画过渡方向
     *  startProgress：动画起点(在整体动画的百分比)
     *  endProgress：动画终点(在整体动画的百分比)
     */
    
    self.index = 1;
}

#pragma mark - 上一页点击事件
- (IBAction)preBtnDidClicked:(id)sender {
    self.index--;
    if (self.index < 1) {
        self.index = 4;
    }
    self.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",self.index]];
    
    // 创建核心动画
    CATransition *ca = [CATransition animation];
    // 告诉要执行什么动画
    // 设置过度效果
    ca.type = @"cube";
    // 设置动画过度方向
    ca.subtype = kCATransitionFromLeft;
    // 设置动画的时间
    ca.duration = 2.0;
    // 添加动画
    [self.iconView.layer addAnimation:ca forKey:nil];
}

#pragma mark - 下一页点击事件
- (IBAction)nextBtnDidClicked:(id)sender {
    self.index++;
    if (self.index > 7) {
        self.index = 1;
    }
    self.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",self.index]];
    
    // 1.创建核心动画
    CATransition *ca = [CATransition animation];
    
    // 1.1告诉要执行什么动画
    // 1.2设置过度效果
    ca.type = @"cube";
    // 1.3设置动画的过度方向
    ca.subtype = kCATransitionFromRight;
    // 1.4设置动画的时间
    ca.duration = 2.0;
    // 1.5设置动画的起点
//    ca.startProgress = 0.5;
    // 1.6设置动画的终点
//    ca.endProgress = 0.5;
    
    // 2.添加动画
    [self.iconView.layer addAnimation:ca forKey:nil];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
