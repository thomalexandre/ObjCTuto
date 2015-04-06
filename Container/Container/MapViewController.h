//
//  MapViewController.h
//  Container
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface MapViewController : UIViewController

@property (nonatomic, weak) IBOutlet MKMapView* mView;

- (void)changeZoomValue:(float)value;


@end
