//
//  SliderViewController.m
//  Container
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)changeZoom:(id)sender
{
    
    UISlider *slider = (UISlider *)sender;
    float value = slider.value;

    // Ugin notifications
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeZoomNotification" object:nil userInfo:@{@"zoomValue": @(value)}];
    
    
    
    //Delegation method
    //    if(self.delegate && [self.delegate respondsToSelector:@selector(sliderViewController:didChangeMapZoomValue:)]) {
//        [self.delegate sliderViewController:self didChangeMapZoomValue:value];
//    }
}

@end
