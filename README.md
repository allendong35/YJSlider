# YJSlider
重写已提供原生slider无法监听的开始和结束状态

## 使用
加入YJSlider.h 和 YJSlider.m
````bash
YJSlider *slider = [[YJSlider alloc]init];
[self.view addSubview:slider];
````
## 三种事件监听

#### 开始
````
[slider addTarget:self action:@selector(sliderBegin:) event:YJSliderBegin];

````
#### 滑动中
````
[slider addTarget:self action:@selector(sliderValueChange:) event:YJSliderValueChanged];

````
#### 结束
````
[slider addTarget:self action:@selector(sliderEnd:) event:YJSliderEnd];

````

