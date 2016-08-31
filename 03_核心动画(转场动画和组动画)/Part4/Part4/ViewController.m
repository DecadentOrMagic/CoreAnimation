//
//  ViewController.m
//  Part4
//
//  Created by 薛尧 on 16/8/30.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  组动画简单说明
     *  CAAnimation的子类，可以保存一组动画对象，将CAAnimationGroup对象加入层后，组中所有动画对象可以同时并发运行
     *  
     * 
     *  属性解析：
     *      animations：用来保存一组动画对象的NSArray
     *      默认情况下，一组动画对象是同时运行的，也可以通过设置动画对象的beginTime属性来更改动画的开始时间
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 平移动画
    CABasicAnimation *a1 = [CABasicAnimation animation];
    a1.keyPath = @"transform.translation.y";
    a1.toValue = @(300);
    // 缩放动画
    CABasicAnimation *a2 = [CABasicAnimation animation];
    a2.keyPath = @"transform.scale";
    a2.toValue = @(0.0);
    // 旋转动画
    CABasicAnimation *a3 = [CABasicAnimation animation];
    a3.beginTime = 0.5;
    a3.keyPath = @"transform.rotation";
    a3.toValue = @(M_PI_2);
    
    // 组动画
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    
    groupAnima.animations = @[a1,a2,a3];
    
    // 设置组动画的时间
    groupAnima.duration = 3;
    groupAnima.fillMode = kCAFillModeForwards;
    groupAnima.removedOnCompletion = NO;
    
    [self.iconView.layer addAnimation:groupAnima forKey:nil];
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
