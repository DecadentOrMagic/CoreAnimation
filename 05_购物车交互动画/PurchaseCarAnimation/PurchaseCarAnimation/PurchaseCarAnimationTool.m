//
//  PurchaseCarAnimationTool.m
//  PurchaseCarAnimation
//
//  Created by 薛尧 on 16/9/7.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "PurchaseCarAnimationTool.h"
#import "AppDelegate.h"

@implementation PurchaseCarAnimationTool

+(instancetype)shareTool
{
    return [[PurchaseCarAnimationTool alloc]init];
}


#pragma mark - 开始动画
- (void)startAnimationandView:(UIView *)view andRect:(CGRect)rect andFinisnRect:(CGPoint)finishPoint andFinishBlock:(animationFinisnBlock)completion
{
    // 图层
    _layer = [CALayer layer];
    _layer.contents = view.layer.contents;
    _layer.contentsGravity = kCAGravityResizeAspectFill;// 调整图片大小
    
    rect.size.width = 60;
    rect.size.height = 60;// 重置图层尺寸
    _layer.bounds = rect;
    
    _layer.cornerRadius = rect.size.width / 2;
    _layer.masksToBounds = YES;// 圆角
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.window.layer addSublayer:_layer];
    
    _layer.position = CGPointMake(rect.origin.x + view.frame.size.width / 2, CGRectGetMidY(rect));// a点
    
    // 路径 (贝塞尔曲线)
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:_layer.position];
    [path addQuadCurveToPoint:finishPoint controlPoint:CGPointMake(ScreenWidth / 2, rect.origin.y - 80)];
    
    //关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = path.CGPath;
    
    //基础动画
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.removedOnCompletion = YES;
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:12];
    rotateAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 组动画
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation,rotateAnimation];
    groups.duration = 1.2f;
    groups.removedOnCompletion = NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
    
    if (completion) {
        _animationFinisnBlock = completion;
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //    [anim def];
    if (anim == [_layer animationForKey:@"group"]) {
        
        [_layer removeFromSuperlayer];
        _layer = nil;
        if (_animationFinisnBlock) {
            _animationFinisnBlock(YES);
        }
    }
}

+(void)shakeAnimation:(UIView *)shakeView
{
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shakeAnimation.duration = 0.25f;
    shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
    shakeAnimation.toValue = [NSNumber numberWithFloat:5];
    shakeAnimation.autoreverses = YES;
    [shakeView.layer addAnimation:shakeAnimation forKey:nil];
}


@end
