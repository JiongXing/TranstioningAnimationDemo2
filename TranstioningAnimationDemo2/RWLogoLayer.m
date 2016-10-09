//
//  RWLogoLayer.m
//  TranstioningAnimationDemo2
//
//  Created by JiongXing on 2016/10/9.
//  Copyright © 2016年 JiongXing. All rights reserved.
//

#import "RWLogoLayer.h"

@implementation RWLogoLayer

+ (CAShapeLayer *)logoLayer {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.geometryFlipped = YES;
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointZero];
    [bezier addCurveToPoint:CGPointMake(0.0, 66.97) controlPoint1:CGPointZero controlPoint2:CGPointMake(0, 57.06)];
    [bezier addCurveToPoint:CGPointMake(16.0, 39.0) controlPoint1:CGPointMake(27.68, 66.97) controlPoint2:CGPointMake(42.35, 52.75)];
    [bezier addCurveToPoint:CGPointMake(26.0, 17.0) controlPoint1:CGPointMake(17.35, 35.41) controlPoint2:CGPointMake(26, 17)];
    [bezier addLineToPoint:CGPointMake(38.0, 34.0)];
    [bezier addLineToPoint:CGPointMake(49.0, 17.0)];
    [bezier addLineToPoint:CGPointMake(67.0, 51.27)];
    [bezier addLineToPoint:CGPointMake(67.0, 0.0)];
    [bezier addLineToPoint:CGPointMake(0.0, 0.0)];
    [bezier closePath];
    
    layer.path = bezier.CGPath;
    layer.bounds = CGPathGetBoundingBox(layer.path);
    
    return layer;
}

@end
