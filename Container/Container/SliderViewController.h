//
//  SliderViewController.h
//  Container
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderViewControllerDelegate;

@interface SliderViewController : UIViewController
@property (nonatomic, weak) id<SliderViewControllerDelegate> delegate;
@end

@protocol SliderViewControllerDelegate <NSObject>
- (void)sliderViewController:(SliderViewController *)vc didChangeMapZoomValue:(float)value;
@end