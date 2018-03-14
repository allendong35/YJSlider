//
//  UIView+YJAnimation.h
//  YuanGongBao
//
//  Created by Kevin on 1/9/15.
//  Copyright (c) 2015 YiJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YJAnimation)

-(void) positionXShake;
-(void) pointOut;
-(void) fadeIn:(CGFloat) duration;
-(void) pointIn;
-(void) scaleXY;
-(void) scaleXY:(CGFloat)value;
-(void) selectAgressAnimation;
-(void) unSelectAgressAnimation;
-(void) pointOutLight;
@end
