/*
 * author DongWei
 *
 * gitHub https://github.com/allendong35
 */

#import <UIKit/UIKit.h>
@class YJSlider,YJSliderButton;

typedef NS_OPTIONS(NSUInteger, YJControlEvents) {
    YJSliderBegin                                                   = 1 <<  0,    
    YJSliderEnd                                                     = 1 <<  1,
    YJSliderValueChanged                                            = 1 << 2,     // sliders, etc.
};

@interface YJSlider : UIControl
/*
 *设置事件
 */
- (void)addTarget:(id)target action:(SEL)action event:(YJControlEvents)event;
/**
 *  当前进度
 */
@property(nonatomic) float value;
/**
 *  最小值
 */
@property(nonatomic) float minimumValue;
/**
 *  最大值
 */
@property(nonatomic) float maximumValue;

/**
 *
 *  当前进度条的颜色，有默认颜色
 */
@property(nonatomic,strong) UIColor *minimumTrackTintColor;
/**
 *  总进度条颜色，有默认颜色
 */
@property(nonatomic,strong) UIColor *maximumTrackTintColor;
/**
 *  设置背景图片
 */
-(void)setBackGroundViewWithImage:(UIImage *)image;
/**
 *  设置拖拽的Thumb图片
 */
@property(nonatomic,strong) UIImage *thumbImage;

@end

@interface YJSliderButton : UIButton

@property (nonatomic,strong)UIImageView *iconImageView;

@end
