//
//  BDWaveView.h
//  BDWaveView-master
//
//  Created by 黄海燕 on 16/9/6.
//  Copyright © 2016年 huanghy. All rights reserved.
//下载地址:https://github.com/huanghaiyan/BDWaveView-master

#import <UIKit/UIKit.h>

@interface BDWaveView : UIView

/**
 *  波浪弯曲程度
 */
@property (nonatomic,assign) CGFloat waveCurvature;
/**
 *  波浪速度
 */
@property (nonatomic,assign) CGFloat waveSpeed;
/**
 *  波浪高度
 */
@property (nonatomic,assign) CGFloat waveHeight;
/**
 *  实际波浪颜色
 */
@property (nonatomic,strong) UIColor *realWaveColor;
/**
 *  遮罩层波浪颜色
 */
@property (nonatomic,strong) UIColor *maskWaveColor;
/**
 *CADisplayLink定时器，绘图常用
 */
@property (nonatomic,strong)CADisplayLink *timer;
/**
 *真实波浪层
 */
@property (nonatomic,strong) CAShapeLayer *realWaveLayer;
/**
 *遮罩波浪层
 */
@property (nonatomic,strong) CAShapeLayer *maskWaveLayer;
/**
 *偏移量
 */
@property (nonatomic,assign) CGFloat offset;
/**
 *用户头像
 */
@property (nonatomic,strong) UIImageView *iconImageView;

//开始波浪动画
- (void)startWaveAnimation;
//结束波浪动画
- (void)stopWaveAnimation;

@end
