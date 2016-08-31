//
//  ViewController.m
//  Part2
//
//  Created by 薛尧 on 16/8/29.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

#define angleRadian(angle) ((angle)/180.0*M_PI)

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *customView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  简单介绍
     *  是CApropertyAnimation的子类，跟CABasicAnimation的区别是：CABasicAnimation只能从一个数值(fromValue)变到另一个数值(toValue)，而CAKeyframeAnimation会使用一个NSArray保存这些数值
     *  
     *  属性解析：
     *  values：就是上述的NSArray对象。里面的元素称为”关键帧”(keyframe)。动画对象会在指定的时间(duration)内，依次显示values数组中的每一个关键帧
     *  path：可以设置一个CGPathRef\CGMutablePathRef,让层跟着路径移动。path只对CALayer的anchorPoint和position起作用。如果你设置了path，那么values将被忽略
     *  keyTimes：可以为对应的关键帧指定对应的时间点,其取值范围为0到1.0,keyTimes中的每一个时间值都对应values中的每一帧.当keyTimes没有设置的时候,各个关键帧的时间是平分的
     *
     *  说明：CABasicAnimation可看做是最多只有2个关键帧的CAKeyframeAnimation
     */
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 第一种方式
//    [self first];
    // 第二种方式 (使用path)让layer在指定的路径上移动(画圆)
//    [self second];
    // 抖动动画
    [self shakeAnimation];
}




#pragma mark - 动画代理方法

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始动画");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"结束动画");
}




#pragma mark - 第一种方式
- (void)first
{
    // 1.创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    // 平移
    keyAnima.keyPath = @"position";
    // 1.1告诉系统要执行什么动画
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(200, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    keyAnima.values = @[value1,value2,value3,value4,value5];
    // 1.2设置动画执行完毕,不能删除动画
    keyAnima.removedOnCompletion = NO;
    // 1.3设置动画的最新状态
    keyAnima.fillMode = kCAFillModeForwards;
    // 1.4设置动画执行的时间
    keyAnima.duration = 4.0;
    // 1.5设置动画的节奏
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // 设置代理,开始-结束
    keyAnima.delegate = self;
    // 2.添加核心动画
    [self.customView.layer addAnimation:keyAnima forKey:nil];
}


#pragma mark - 第二种方式 (使用path)让layer在指定的路径上移动(画圆)
- (void)second
{
    // 创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    // 平移
    keyAnima.keyPath = @"position";
    // 1.1告诉系统要执行什么动画
    // 创建一条路径
    CGMutablePathRef path = CGPathCreateMutable();
    // 设置一个圆的半径
    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    keyAnima.path = path;
    
    // 有create就一定要有release
    CGPathRelease(path);
    // 1.2设置动画执行完毕后,不能删除动画
    keyAnima.removedOnCompletion = NO;
    // 1.3设置保存动画的最新状态
    keyAnima.fillMode = kCAFillModeForwards;
    // 1.4设置动画执行的时间
    keyAnima.duration = 5.0;
    // 1.5设置动画的节奏
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    // 设置代理,开始-结束
    keyAnima.delegate = self;
    // 2.添加核心动画
    [self.customView.layer addAnimation:keyAnima forKey:@"wendingding"];
    
    // 说明：可以通过path属性，让layer在指定的轨迹上运动。
}


#pragma mark - 停止动画
- (IBAction)stopAnimation:(id)sender {
    // 停止self.customView.layer上名称标示为wedingding的动画
    [self.customView.layer removeAnimationForKey:@"wendingding"];
}


#pragma mark - 图标抖动
- (void)shakeAnimation
{
    // 1.创建核心动画
    CAKeyframeAnimation *keyAnima = [CAKeyframeAnimation animation];
    keyAnima.keyPath = @"transform.rotation";
    // 设置动画时间
    keyAnima.duration = 0.1;
    // 设置图标抖动弧度
    // 把度数转化为弧度 度数/180*M_PI
    keyAnima.values = @[@(-angleRadian(4)),@(angleRadian(4)),@(-angleRadian(4))];
    // 设置图画动画的重复次数(设置最大值)
    keyAnima.repeatCount = MAXFLOAT;
    
    keyAnima.fillMode = kCAFillModeForwards;
    keyAnima.removedOnCompletion = NO;
    // 2.添加动画
    [self.iconView.layer addAnimation:keyAnima forKey:nil];
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
