//
//  CustomView.h
//  CustomDrawing
//
//  Created by Alexandre THOMAS on 01/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomView : UIView


@property (nonatomic) IBInspectable CGFloat lineWidth;
@property (nonatomic) IBInspectable UIColor *lineColor;

@end
