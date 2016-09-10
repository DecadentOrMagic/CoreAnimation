//
//  PurchaseCarAnimationTool.h
//  PurchaseCarAnimation
//
//  Created by 薛尧 on 16/9/7.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

typedef void (^animationFinisnBlock)(BOOL finish);

@interface PurchaseCarAnimationTool : NSObject


@property (strong , nonatomic) CALayer *layer;
@property (copy , nonatomic) animationFinisnBlock animationFinisnBlock;



/**
 *  初始化
 *
 *  @return 返回一个PurchaseCarAnimationTool类对象
 */
+(instancetype)shareTool;

/**
 *  开始动画
 *
 *  @param view                 添加动画的view
 *  @param rect                 view 的绝对frame
 *  @param finishPoint          下落的位置
 *  @param animationFinisnBlock 动画完成回调
 */
-(void)startAnimationandView:(UIView *)view andRect:(CGRect)rect andFinisnRect:(CGPoint)finishPoint andFinishBlock:(animationFinisnBlock)completion;

/**
 *  摇晃动画
 *
 *  @param shakeView 摇晃的视图
 */
+(void)shakeAnimation:(UIView *)shakeView;

@end
