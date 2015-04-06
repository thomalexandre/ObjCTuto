//
//  MapViewController.m
//  Earthquake
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "MapViewController.h"
#import "Location.h"
#import "Annotation.h"
#import "Quake.h"
#import "QuakeWeb.h"
#import "WebViewController.h"

@interface MapViewController () <MKMapViewDelegate>
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(self.location.quakeLatitute.doubleValue, self.location.quakeLongitude.doubleValue);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, 1000000, 1000000);
    self.mapView.region = region;
    self.mapView.delegate = self;
    
    Annotation *annotation = [[Annotation alloc] init];
    annotation.coordinate = center;
    annotation.title = self.location.quake.quakeLocation;
    annotation.subtitle = [self.location.quake.quakeMagnitude stringValue];
    annotation.location = self.location;
    
    [self.mapView addAnnotation:annotation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"com.kinja.pin";
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if(pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    pin.enabled = YES;
    pin.selected = YES;
    pin.canShowCallout = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pin.rightCalloutAccessoryView = button;
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    Annotation *annotation = (Annotation *)view.annotation;
    Location *location = annotation.location;
    NSString *url = location.quakeWeb.quakeURL;
    
    // push to next view controller
    WebViewController *viewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    viewController.url = url;
    [self showViewController:viewController sender:nil];
    
    NSLog(@"asdsad");
}
@end
