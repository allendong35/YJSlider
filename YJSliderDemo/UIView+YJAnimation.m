//
//  UIView+YJAnimation.m
//  YuanGongBao
//
//  Created by Kevin on 1/9/15.
//  Copyright (c) 2015 YiJie. All rights reserved.
//

#import "UIView+YJAnimation.h"

@implementation UIView (YJAnimation)

-(void) selectAgressAnimation
{
    self.hidden = NO;
//    return;
    [self.layer removeAnimationForKey:@"unselectAgressAnimation"];
//    CATransform3D t1 = CATransform3DMakeScale(0, 0, 0);
//    NSValue * v1 = [NSValue valueWithCATransform3D:t1];
//    CATransform3D t2 = CATransform3DMakeScale(2, 2, 0);
//    NSValue * v2 = [NSValue valueWithCATransform3D:t2];
//    CATransform3D t3 = CATransform3DMakeScale(0.8, 0.8, 1);
//    NSValue * v3 = [NSValue valueWithCATransform3D:t3];
//    CATransform3D t4 = CATransform3DMakeScale(1, 1, 1);
//    NSValue * v4 = [NSValue valueWithCATransform3D:t4];
//    NSArray * values = @[v1,v2,v3,v4];
//    CAKeyframeAnimation * animation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//    animation1.values = values;
//    animation1.duration = 0.5;
//    animation1.removedOnCompletion = NO;
//    animation1.calculationMode = kCAAnimationCubic;
//    animation1.fillMode = kCAFillModeForwards;
//    animation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [self.layer addAnimation:animation1 forKey:@"selectAgressAnimation"];
//    self.layer.transform=t1;
    
    //    方法一 用法1​ Value方式
    //创建动画对象
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //设置value
    
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(0, 20)];
    
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(10, 50)];
    
//    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
//
//    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
//
//    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 300)];
//
//    NSValue *value6=[NSValue valueWithCGPoint:CGPointMake(200, 400)];
//
    animation.values=@[value1,value2];
    
    //重复次数 默认为1
    
    animation.repeatCount=1;
    
    //设置是否原路返回默认为不
    
    animation.autoreverses = YES;
    
    //设置移动速度，越小越快
    
    animation.duration = 4.0f;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
//    animation.delegate=self;
    
    //给这个view加上动画效果
    
    [self.layer addAnimation:animation forKey:@"selectAgressAnimation"];
}

-(void) unSelectAgressAnimation
{
    self.hidden = YES;
//    return;
    [self.layer removeAnimationForKey:@"selectAgressAnimation"];
    CATransform3D t1 = CATransform3DMakeScale(1, 1, 1);
    NSValue * v1 = [NSValue valueWithCATransform3D:t1];
    CATransform3D t2 = CATransform3DMakeScale(2, 2, 1);
    NSValue * v2 = [NSValue valueWithCATransform3D:t2];
    CATransform3D t3 = CATransform3DMakeScale(0, 0, 1);
    NSValue * v3 = [NSValue valueWithCATransform3D:t3];
    NSArray * values = @[v1,v2,v3];
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = values;
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.calculationMode = kCAAnimationCubic;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animation forKey:@"unselectAgressAnimation"];
    self.layer.transform=t3;

}
@end
