//
//  ViewController.m
//  Part5
//
//  Created by 薛尧 on 16/8/31.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  简单说明
     *
     *  UIKit直接将动画集成到UIView类中，当内部的一些属性发生改变时，UIView将为这些改变提供动画支持
     *  执行动画所需要的工作由UIView类自动完成，但仍要在希望执行动画时通知视图，为此需要将改变属性的代码放在[UIView beginAnimations:nil context:nil]和[UIView commitAnimations]之间
     *
     *  常见方法解析:
     *  + (void)setAnimationDelegate:(id)delegate     设置动画代理对象，当动画开始或者结束时会发消息给代理对象
     *  + (void)setAnimationWillStartSelector:(SEL)selector   当动画即将开始时，执行delegate对象的selector，并且把beginAnimations:context:中传入的参数传进selector
     *  + (void)setAnimationDidStopSelector:(SEL)selector  当动画结束时，执行delegate对象的selector，并且把beginAnimations:context:中传入的参数传进selector
     *  + (void)setAnimationDuration:(NSTimeInterval)duration   动画的持续时间，秒为单位
     *  + (void)setAnimationDelay:(NSTimeInterval)delay  动画延迟delay秒后再开始
     *  + (void)setAnimationStartDate:(NSDate *)startDate   动画的开始时间，默认为now
     *  + (void)setAnimationCurve:(UIViewAnimationCurve)curve  动画的节奏控制
     *  + (void)setAnimationRepeatCount:(float)repeatCount  动画的重复次数
     *  + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses  如果设置为YES,代表动画每次重复执行的效果会跟上一次相反
     *  + (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache  设置视图view的过渡效果, transition指定过渡类型, cache设置YES代表使用视图缓存，性能较好
     */
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1.UIView动画(首尾)
//    [self viewAnimation];
    // 2.Block动画
    [self blockAnimation];
}




#pragma mark - 1.UIView动画(首尾)
- (void)viewAnimation
{
    // 打印动画块的位置
    NSLog(@"动画块执行之前的位置:%@",NSStringFromCGPoint(self.customView.center));
    
    // 首尾式动画
    [UIView beginAnimations:nil context:nil];
    // 执行动画
    // 设置动画执行时间
    [UIView setAnimationDuration:2.0];
    // 设置代理
    [UIView setAnimationDelegate:self];
    // 设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(didStopAnimation)];
    self.customView.center = CGPointMake(200, 300);
    [UIView commitAnimations];
    
    /**
     *  UIView封装的动画与CALayer动画的对比
     *
     *  使用UIView和CALayer都能实现动画效果，但是在真实的开发中，一般还是主要使用UIView封装的动画，而很少使用CALayer的动画。
     *  CALayer核心动画与UIView动画的区别：
     *  UIView封装的动画执行完毕之后不会反弹。即如果是通过CALayer核心动画改变layer的位置状态，表面上看虽然已经改变了，但是实际上它的位置是没有改变的。
     */
}

- (void)didStopAnimation
{
    NSLog(@"动画执行完毕");
    // 打印动画块的位置
    NSLog(@"动画执行之后的位置：%@",NSStringFromCGPoint(self.customView.center));
}


#pragma mark - 2.Block动画
- (void)blockAnimation
{
    /**
     *  简单说明
     *  + (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
     *  
     *  参数解析:
     *      duration：动画的持续时间
     *      delay：动画延迟delay秒后开始
     *      options：动画的节奏控制
     *      animations：将改变视图属性的代码放在这个block中
     *      completion：动画结束后，会自动调用这个block
     *
     *
     *  转场动画
     *  + (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
     *
     *  参数解析:
     *  duration：动画的持续时间
     *  view：需要进行转场动画的视图
     *  options：转场动画的类型
     *  animations：将改变视图属性的代码放在这个block中
     *  completion：动画结束后，会自动调用这个block
     *
     *
     *  + (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion
     *  方法调用完毕后，相当于执行了下面两句代码：
     *  // 添加toView到父视图
     *  [fromView.superview addSubview:toView]; 
     *  // 把fromView从父视图中移除
     *  [fromView.superview removeFromSuperview];
     * 
     *  参数解析:
     *  duration：动画的持续时间
     *  options：转场动画的类型
     *  animations：将改变视图属性的代码放在这个block中
     *  completion：动画结束后，会自动调用这个block
     */
    
    // block代码块动画
    [UIView transitionWithView:self.customView duration:3.0 options:0 animations:^{
        // 执行动画
        NSLog(@"动画开始执行前的位置：%@",NSStringFromCGPoint(self.customView.center));
        self.customView.center=CGPointMake(200, 300);
    } completion:^(BOOL finished) {
        //动画执行完毕后的首位操作
        NSLog(@"动画执行完毕");
        NSLog(@"动画执行完毕后的位置：%@",NSStringFromCGPoint( self.customView.center));
    }];
    // 提示：self.customView.layer.position和self.customView.center等价，因为position的默认值为（0.5，0.5）。
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
