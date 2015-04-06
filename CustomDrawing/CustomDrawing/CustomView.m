//
//  CustomView.m
//  CustomDrawing
//
//  Created by Alexandre THOMAS on 01/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)drawRect:(CGRect)rect
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = CGRectMake(0, 0, rect.size.width, rect.size.height);
    shapeLayer.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGPathRef path = CGPathCreateWithEllipseInRect(rect, nil);
    shapeLayer.path = path;
    shapeLayer.strokeColor = [self.lineColor CGColor];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.strokeStart = 0.0;
    shapeLayer.strokeEnd = 0.75;
    shapeLayer.lineWidth = self.lineWidth;
    
    [self.layer addSublayer:shapeLayer];
}


@end
