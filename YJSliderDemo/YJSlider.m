//
//  YJSlider.m
//  YJSliderDemo
//
//  Created by Dong on 18/2/28.
//  Copyright © 2018年 Dong. All rights reserved.
//

#import "YJSlider.h"
static CGFloat sliderButtonHegiht = 24.0f;
static CGFloat sliderHegiht = 4.0f;

@interface YJSlider ()

/*
 *Invocation集合
 */
@property (nonatomic, strong) NSMutableDictionary * invDic;
/**
 *  已播放进度条
 */
@property (nonatomic,strong)UIView *minimumTrackView;
/**
 *  剩余进度条
 */
@property (nonatomic,strong)UIView *maximumTrackView;

/**
 *  背景设置
 */
@property (nonatomic,strong)UIImageView *backGroundView;

/**
 *  滑动按钮
 */
@property (nonatomic,strong)YJSliderButton *sliderButton;

@property (nonatomic,assign)CGFloat minimumTrackViewWidth;
@property (nonatomic,assign)CGFloat sliderButtonCenterX;

@end

@implementation YJSlider{
    CGPoint _lastPoint;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initSubviews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    [self addSubview:self.maximumTrackView];
    [self addSubview:self.minimumTrackView];
    
    [self addSubview:self.sliderButton];
    
    [self defaultSetting];
    
}


- (void)addTarget:(id)target action:(SEL)action event:(YJControlEvents)event
{
    NSMethodSignature * sig = [[target class] instanceMethodSignatureForSelector:action];
    if(sig == nil){
        // 抛出异常
        NSString *reason = [NSString stringWithFormat:@"%@方法不存在",NSStringFromSelector(action)];
        @throw [NSException exceptionWithName:@"error" reason:reason userInfo:nil];
    }
    
    NSInvocation * inv = [NSInvocation invocationWithMethodSignature:sig];
    [inv setTarget:target];
    [inv setSelector:action];
    YJSlider *slider = self;
    [inv setArgument:&slider atIndex:2];
    [self.invDic setObject:inv forKey:@(event)];
}

-(void)setBackGroundViewWithImage:(UIImage *)image{
    if (_backGroundView == nil) {
        _backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height-sliderHegiht)*0.5, self.bounds.size.width, sliderHegiht)];
        _backGroundView.layer.cornerRadius = sliderHegiht *0.5;
        _backGroundView.layer.masksToBounds = YES;
        [self insertSubview:_backGroundView atIndex:0];
    }
    [_backGroundView setImage:image];
}

-(NSMutableDictionary *)invDic{
    if (_invDic == nil) {
        _invDic = [NSMutableDictionary dictionary];
    }
    return _invDic;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self initFrame];
}

- (void)defaultSetting{
    self.value = 0.0f;
    self.minimumValue = 0.0f;
    self.maximumValue = 1.0f;
    self.backgroundColor = [UIColor clearColor];
    self.minimumTrackView.backgroundColor = [UIColor colorWithRed:58 / 256.0 green:142 / 256.0 blue:245 / 256.0 alpha:1];
    self.maximumTrackView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
}

- (void)initFrame{
    CGFloat trackViewX = sliderButtonHegiht * 0.5;
    CGFloat trackViewY = (self.frame.size.height - sliderHegiht ) / 2;
    CGFloat trackViewWidth = self.frame.size.width - sliderButtonHegiht;
    self.maximumTrackView.frame = CGRectMake(trackViewX, trackViewY, trackViewWidth, sliderHegiht);
    self.minimumTrackView.frame = CGRectMake(trackViewX, trackViewY, self.minimumTrackViewWidth, sliderHegiht);
    self.sliderButton.frame = CGRectMake(0, trackViewY, sliderButtonHegiht, sliderButtonHegiht);
    CGPoint center = self.sliderButton.center;
    center.x = self.sliderButtonCenterX ? self.sliderButtonCenterX : self.maximumTrackView.frame.origin.x;
    center.y = self.minimumTrackView.center.y;
    self.sliderButton.center = center;
    _lastPoint = center;
}


- (void) dragMoving: (UIButton *)btn withEvent:(UIEvent *)event{
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    CGFloat offsetX = point.x - _lastPoint.x;
    CGPoint tempPoint = CGPointMake(btn.center.x + offsetX, btn.center.y);
    
    // 得到进度值
    CGFloat progressValue = (tempPoint.x - self.maximumTrackView.frame.origin.x) * 1.0f / self.maximumTrackView.frame.size.width;
    [self setValue:progressValue animated:YES];
    
    NSInvocation *inv = [self.invDic objectForKey:@(YJSliderValueChanged)];
    if (inv) {
        [inv invoke];
    }
}

// 开始拖动
- (void)beiginSlider{
    NSInvocation *inv = [self.invDic objectForKey:@(YJSliderBegin)];
    if (inv) {
        [inv invoke];
    }
}
// 结束拖动
- (void)endSlider{
    NSInvocation *inv = [self.invDic objectForKey:@(YJSliderEnd)];
    if (inv) {
        [inv invoke];
    }
}

- (void)setValue:(float)value animated:(BOOL)animated{
    _value = value;
    [self layoutSubviews];
    CGFloat finishValue = self.maximumTrackView.frame.size.width * value;
    CGPoint tempPoint = self.sliderButton.center;
    tempPoint.x =  self.maximumTrackView.frame.origin.x + finishValue;
    
    if (tempPoint.x >= self.maximumTrackView.frame.origin.x &&
        tempPoint.x <= (self.frame.size.width - (sliderButtonHegiht * 0.5))){
        _lastPoint = tempPoint;
        // 记录
        self.sliderButtonCenterX = tempPoint.x;
        self.minimumTrackViewWidth = tempPoint.x;
        // 重新布局
        [self layoutSubviews];
    }
    if (tempPoint.x <= self.maximumTrackView.frame.origin.x) {
        if (_minimumValue) {
            _value = _minimumValue;
        }
        else{
            _value = 0.0;
        }
    }
    else if(tempPoint.x >= self.frame.size.width - (sliderButtonHegiht * 0.5)){
        if (_maximumValue) {
            _value = _maximumValue;
        }
        else{
            _value = 1.0;
        }
    }
    
    else {
        _value =_value* (_maximumValue-_minimumValue)+_minimumValue;
    }
    
}

- (void)setThumbImage:(nullable UIImage *)image forState:(UIControlState)state{
    _thumbImage = image;
    self.sliderButton.iconImageView.image = image;
}


#pragma mark -- Setter & Getter

- (void)setValue:(float)value{
    value = (value-_minimumValue)/(_maximumValue-_minimumValue);
    [self setValue:value animated:NO];
}

- (void)setThumbImage:(UIImage *)thumbImage{
    [self setThumbImage:thumbImage forState:UIControlStateNormal];
}

- (void)setMinimumValue:(float)minimumValue{
    _minimumValue = minimumValue;
}

- (void)setMaximumValue:(float)maximumValue{
    _maximumValue = maximumValue;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor{
    _minimumTrackTintColor = minimumTrackTintColor;
    self.minimumTrackView.backgroundColor = minimumTrackTintColor;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor{
    _maximumTrackTintColor = maximumTrackTintColor;
    self.maximumTrackView.backgroundColor = maximumTrackTintColor;
}

- (UIView *)minimumTrackView{
    if (_minimumTrackView == nil) {
        _minimumTrackView = [[UIView alloc] init];
    }
    return _minimumTrackView;
}

- (UIView *)maximumTrackView{
    if (_maximumTrackView == nil) {
        _maximumTrackView = [[UIView alloc] init];
    }
    return _maximumTrackView;
}

- (UIButton *)sliderButton{
    if (_sliderButton == nil) {
        [_sliderButton setBackgroundColor:[UIColor redColor]];
        _sliderButton = [[YJSliderButton alloc] init];
        [_sliderButton addTarget:self action:@selector(beiginSlider) forControlEvents:UIControlEventTouchDown];
        [_sliderButton addTarget:self action:@selector(endSlider) forControlEvents:UIControlEventTouchCancel];
        [_sliderButton addTarget:self action:@selector(dragMoving:withEvent:) forControlEvents:UIControlEventTouchDragInside];
        [_sliderButton addTarget:self action:@selector(dragMoving:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
        [_sliderButton addTarget:self action:@selector(endSlider) forControlEvents:UIControlEventTouchUpInside];
        [_sliderButton addTarget:self action:@selector(endSlider) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _sliderButton;
}

@end


@implementation YJSliderButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initImageView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initImageView];
    }
    return self;
}

- (void)initImageView{
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_iconImageView];
    
    [self layoutSubviews];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _iconImageView.frame = CGRectMake(0,0,sliderButtonHegiht, sliderButtonHegiht);
}

@end
