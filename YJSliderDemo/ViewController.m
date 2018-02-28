//
//  ViewController.m
//  YJSliderDemo
//
//  Created by song on 2018/2/28.
//  Copyright © 2018年 YiJie. All rights reserved.
//

#import "ViewController.h"
#import "YJSlider.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSlider];
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
