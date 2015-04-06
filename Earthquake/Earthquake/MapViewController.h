//
//  MapViewController.h
//  Earthquake
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Location;
@import MapKit;

@interface MapViewController : UIViewController
@property (nonatomic, strong) Location *location;
@end
