//
//  BDWaveView.m
//  BDWaveView-master
//
//  Created by 黄海燕 on 16/9/6.
//  Copyright © 2016年 huanghy. All rights reserved.
//下载地址:https://github.com/huanghaiyan/BDWaveView-master

#import "BDWaveView.h"

@implementation BDWaveView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initWaveView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWaveView];
    }
    return self;
}


- (void)initWaveView
{
    self.waveSpeed = 0.7;
    self.waveCurvature = 1.5;
    self.waveHeight = 8;
    self.realWaveColor = [UIColor whiteColor];
    self.maskWaveColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    
    [self addSubview:self.iconImageView];
    
    [self.layer addSublayer:self.realWaveLayer];
    [self.layer addSublayer:self.maskWaveLayer];
    
    [self startWaveAnimation];
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-30, -60, 60, 60)];
        _iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _iconImageView.layer.borderWidth = 2;
        _iconImageView.layer.cornerRadius = 20;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (CAShapeLayer *)realWaveLayer
{
    if (!_realWaveLayer) {
        _realWaveLayer = [CAShapeLayer layer];
        _realWaveLayer.frame = self.bounds;
        _realWaveLayer.fillColor = self.realWaveColor.CGColor;
    }
    return _realWaveLayer;
}

- (CAShapeLayer *)maskWaveLayer
{
    if (!_maskWaveLayer) {
        _maskWaveLayer = [CAShapeLayer layer];
        _maskWaveLayer.frame = self.bounds;
        _maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    }
    return _maskWaveLayer;
}

- (void)startWaveAnimation
{
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
    [self.timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopWaveAnimation
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)wave
{
    self.offset += self.waveSpeed;
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    //真实波浪
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, height);
    CGFloat y = 0.f;
    for (CGFloat x= 0.f; x <= width; x++) {
        y = height *sinf(0.01*self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    CGFloat centX = self.bounds.size.width/2;
    CGFloat centY = height * sinf(0.01 *self.waveCurvature * centX + self.offset *0.045);
    CGRect iconFrame = [self.iconImageView frame];
    iconFrame.origin.y = centY - 60;
    self.iconImageView.frame = iconFrame;
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.realWaveLayer.path = path;
    self.realWaveLayer.fillColor = self.realWaveColor.CGColor;
    CGPathRelease(path);
    
    //遮罩层波浪
    CGMutablePathRef maskPath = CGPathCreateMutable();
    CGPathMoveToPoint(maskPath, NULL, 0, height);
    CGFloat maskY = 0.f;
    for (CGFloat x = 0.f; x <= width; x++) {
        maskY = height * cosf(0.01 * self.waveCurvature * x + self.offset * 0.045);
        CGPathAddLineToPoint(maskPath, NULL, x, maskY);
    }
    CGPathAddLineToPoint(maskPath, NULL, width, height);
    CGPathAddLineToPoint(maskPath, NULL, 0, height);
    CGPathCloseSubpath(maskPath);
    self.maskWaveLayer.path = maskPath;
    self.maskWaveLayer.fillColor = self.maskWaveColor.CGColor;
    CGPathRelease(maskPath);
}

- (void)dealloc
{
    [self stopWaveAnimation];
    if (_realWaveLayer) {
        [_realWaveLayer removeFromSuperlayer];
        _realWaveLayer = nil;
    }
    
    if (_maskWaveLayer) {
        [_maskWaveLayer removeFromSuperlayer];
        _maskWaveLayer = nil;
    }
}

@end
