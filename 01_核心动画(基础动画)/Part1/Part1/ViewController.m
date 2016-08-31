//
//  ViewController.m
//  Part1
//
//  Created by 薛尧 on 16/8/29.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  简单介绍
     *  CAPropertyAnimation的子类
     *
     *  属性解析:
     *  fromValue：keyPath相应属性的初始值
     *  toValue：keyPath相应属性的结束值
     *  随着动画的进行，在长度为duration的持续时间内，keyPath相应属性的值从fromValue渐渐地变为toValue
     *  如果fillMode=kCAFillModeForwards和removedOnComletion=NO，那么在动画执行完毕后，图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变。
     *  比如，CALayer的position初始值为(0,0)，CABasicAnimation的fromValue为(10,10)，toValue为(100,100)，虽然动画执行完毕后图层保持在(100,100)这个位置，实质上图层的position还是为(0,0)
     */
    
    // 创建layer
    CALayer *layer = [CALayer layer];
    // 设置layer的属性
    layer.bounds = CGRectMake(0, 0, 50, 80);
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    layer.position = CGPointMake(50, 50);
    layer.anchorPoint = CGPointMake(0, 0);
    layer.cornerRadius = 20;
    // 添加layer
    [self.view.layer addSublayer:layer];
    self.layer = layer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 平移动画
    [self pingyiaAnimation];
    // 缩放动画
//    [self suofangAnimation];
    // 旋转动画
//    [self xuanzhuanAnimation];
    // 补充
//    [self buchong];
}




//----------------------------------------------------------------//
//---------------- 平移动画 -------------------//

#pragma mark - 平移动画
- (void)pingyiaAnimation
{
    // 1.创建核心动画
//    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:<#(nullable NSString *)#>];
    CABasicAnimation *anima = [CABasicAnimation animation];
    
    // 1.1告诉系统要执行什么样的动画
    anima.keyPath = @"position";// 设置的keyPath是@"position"，说明要修改的是CALayer的position属性，也就是会执行平移动画
    // 设置通过动画,将layer从哪儿移动到哪儿
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    // byValue和toValue的区别，前者是在当前的位置上增加多少，后者是到指定的位置
//    anima.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    
    // 1.2设置动画执行完毕之后不删除动画
    // 默认情况下，动画执行完毕后，动画会自动从CALayer上移除，CALayer又会回到原来的状态。为了保持动画执行后的状态，可以加入下面两行代码
    anima.removedOnCompletion = NO;
    // 1.3设置保存动画的最新状态
    anima.fillMode = kCAFillModeForwards;
    
    // 设置动画的代理，可以监听动画的执行过程，这里设置控制器为代理。
    anima.delegate = self;
    // 打印
    NSString *str = NSStringFromCGPoint(self.layer.position);
    NSLog(@"执行前:---%@",str);
    
    
    // 2.将核心动画添加到layer
    [self.layer addAnimation:anima forKey:nil];
}

#pragma mark - 动画的代理方法
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始动画");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 动画执行完毕,打印执行完毕后的position值
    NSString *str = NSStringFromCGPoint(self.layer.position);
    NSLog(@"执行后:---%@",str);
    // 打印position的属性值，验证图层的属性值还是动画执行前的初始值{50，50}，并没有真正被改变为{200，300}。
}




//----------------------------------------------------------------//
//---------------- 缩放动画 -------------------//

#pragma mark - 缩放动画
- (void)suofangAnimation
{
    // 1.创建动画
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"bounds"];
    // 1.1设置动画执行事件
    anima.duration = 2.0;
    // 1.2设置动画执行完毕后不删除动画
    anima.removedOnCompletion = NO;
    // 1.3设置保存动画的最新状态
    anima.fillMode = kCAFillModeForwards;
    // 1.4修改属性,执行动画
    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    // 2.添加动画到layer
    [self.layer addAnimation:anima forKey:nil];
}




//----------------------------------------------------------------//
//---------------- 旋转动画 -------------------//

#pragma mark - 旋转动画
- (void)xuanzhuanAnimation
{
    // 1.创建动画
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform"];
    // 1.1设置动画执行时间
    anima.duration = 2.0;
    // 1.2修改属性,执行动画
    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2 + M_PI_4, 1, 1, 0)];
    // 1.3设置动画执行完毕后不删除动画
    anima.removedOnCompletion = NO;
    // 1.4设置保存动画的最新状态
    anima.fillMode = kCAFillModeForwards;
    
    // 2.添加动画到layer
    [self.layer addAnimation:anima forKey:nil];
}




//----------------------------------------------------------------//
//---------------- 补充 -------------------//

#pragma mark - 补充
- (void)buchong
{
    // 可以通过transform（KVC）的方式来进行设置。
    // 代码示例:平移
    // 1.创建动画
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.keyPath = @"transform";
    // 1.1设置动画执行时间
    anima.duration = 2.0;
    // 1.2修改属性,执行动画
    anima.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 100, 1)];
    // 1.3设置动画执行完毕后不删除动画
    anima.removedOnCompletion = NO;
    // 1.4设置保存动画的最新状态
    anima.fillMode = kCAFillModeForwards;
    
    // 2.添加动画到layer
    [self.layer addAnimation:anima forKey:nil];
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
