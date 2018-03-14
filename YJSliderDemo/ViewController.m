//
//  ViewController.m
//  YJSliderDemo
//
//  Created by song on 2018/2/28.
//  Copyright © 2018年 YiJie. All rights reserved.
//

#import "ViewController.h"
#import "YJSlider.h"
#import "UIView+YJAnimation.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+Tracking.h"
@interface ViewController ()
{
    CAShapeLayer *arcLayer;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageArrow;
@property (weak, nonatomic) IBOutlet UIButton *btnTrack;
@property (nonatomic) BOOL isAgreeSelected;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSlider];
    [self.imageArrow unSelectAgressAnimation];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
//    CGRect rect=[UIScreen mainScreen].bounds;
    
    // 设置起点
    [path moveToPoint:CGPointMake(0, 100)];
    //把点加入到路径里面
    [path addLineToPoint:CGPointMake(400, 300)];
    [path addLineToPoint:CGPointMake(100, 0)];
    arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;//46,169,230
    arcLayer.fillColor = [UIColor clearColor].CGColor;
    arcLayer.strokeColor=[UIColor colorWithWhite:0 alpha:0.7].CGColor;
    arcLayer.lineWidth=4;
    arcLayer.frame=self.view.frame;
    [self.view.layer addSublayer:arcLayer];
    [self drawLineAnimation:arcLayer];
    
    [self.btnTrack addTarget:self action:@selector(trackingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnTrack enableEventTracking];

}

- (void)trackingButtonAction:(UIButton *)sender
{
    // to do whatever you want...
//    NSLog(@"%s", __func__);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"aaa" message:@"sss" delegate:nil cancelButtonTitle:@"aa" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=1;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}

-(void)initSlider{
    YJSlider *slider = [[YJSlider alloc]initWithFrame:CGRectMake(20, 400,300, 18)];
    slider.minimumTrackTintColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    slider.maximumTrackTintColor = [UIColor colorWithWhite:0.6 alpha:1];
    [slider setThumbImage:[UIImage imageNamed:@"sliderBtn"]];
    [slider addTarget:self action:@selector(sliderBegin:) event:YJSliderBegin];
    
    [slider addTarget:self action:@selector(sliderValueChange:) event:YJSliderValueChanged];
    
    [slider addTarget:self action:@selector(sliderEnd:) event:YJSliderEnd];
    [self.view addSubview:slider];
}

- (IBAction)btn:(id)sender {
    
    _isAgreeSelected = !_isAgreeSelected;
    if(_isAgreeSelected)
    {
        [self.imageArrow selectAgressAnimation];
    }
    else
    {
        [self.imageArrow unSelectAgressAnimation];
    }
    
}

-(void)sliderBegin:(YJSlider *)sender{
    NSLog(@"begin");
}

-(void)sliderValueChange:(YJSlider *)sender{
    NSLog(@"valueChange===>%f",sender.value);
}

-(void)sliderEnd:(YJSlider *)sender{
    NSLog(@"end");
}

@end
