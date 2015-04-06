//
//  ViewController.m
//  Container
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"
#import "MapViewController.h"
#import "TableViewController.h"
#import "SliderViewController.h"

@interface ViewController () <SliderViewControllerDelegate>

@property (nonatomic, strong) MapViewController *mapVC;
@property (nonatomic, strong) TableViewController *tableVC;
@property (nonatomic, strong) SliderViewController *sliderVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mapVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    self.tableVC = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    self.sliderVC = [[SliderViewController alloc] initWithNibName:@"SliderViewController" bundle:nil];
    self.sliderVC.delegate = self;
    
    // add the children to the main view controller
    [self addChildViewController:self.mapVC];
    [self addChildViewController:self.tableVC];
    [self addChildViewController:self.sliderVC];
    
    // add the different views to the main view
    [self.view addSubview:self.mapVC.view];
    [self addConstraintsToMapView:self.mapVC.view];
    [self.view addSubview:self.tableVC.view];
    [self addConstraintsToTableView:self.tableVC.view];
    [self.view addSubview:self.sliderVC.view];
    [self addConstraintsToSliderView:self.sliderVC.view];
    
    // mandatory step, this step should be at the end for the subview contrler
    [self.mapVC didMoveToParentViewController:self];
    [self.tableVC didMoveToParentViewController:self];
    [self.sliderVC didMoveToParentViewController:self];
}

- (void)addConstraintsToMapView:(UIView *) view
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1
                                                                         constant:0];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:0];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:0];
    
    [self.view addConstraints:@[topConstraint, leftConstraint, bottomConstraint, rightConstraint]];
}

- (void)addConstraintsToTableView:(UIView *) view
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:0];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:0];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1
                                                                        constant:0];
    
    [self.view addConstraints:@[topConstraint, leftConstraint, bottomConstraint, rightConstraint]];
}

- (void)addConstraintsToSliderView:(UIView *) view
{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1
                                                                      constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:0];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.view
                                                                      attribute:NSLayoutAttributeCenterX
                                                                     multiplier:1
                                                                       constant:0];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:0];
    
    [self.view addConstraints:@[topConstraint, leftConstraint, bottomConstraint, rightConstraint]];
}

- (void)sliderViewController:(SliderViewController *)vc didChangeMapZoomValue:(float)value
{
    [self.mapVC changeZoomValue:value];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
