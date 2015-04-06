//
//  MapViewController.m
//  Container
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "MapViewController.h"
#import "Annotation.h"

@interface MapViewController () <MKMapViewDelegate>

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeZoomNotification:) name:@"ChangeZoomNotification" object:nil];
    
    // Budapest
    //47.49562 19.05666
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(47.49562, 19.05666);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, 4000, 4000);
    self.mView.region = region;
    self.mView.delegate = self;
    
    Annotation *annotation = [[Annotation alloc] init];
    annotation.coordinate = center;
    annotation.title = @"Budapest";
    annotation.subtitle = @"Nice City";
    [self.mView addAnnotation:annotation];
}

- (void)dealloc
{
    // remove the observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ChangeZoomNotification" object:nil];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"com.kinja.pin";
    MKAnnotationView *pin = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(pin == nil) {
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    pin.enabled = YES;
    pin.canShowCallout = YES;
    pin.image = [UIImage imageNamed:@"pin"];
    pin.centerOffset = CGPointMake(0, -pin.image.size.height/2);
    
    return pin;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeZoomNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    float value = [userInfo[@"zoomValue"] floatValue];
    [self changeZoomValue:value];
}

- (void)changeZoomValue:(float)value
{
    CLLocationCoordinate2D center = self.mView.region.center;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(center, value, value);
    [self.mView setRegion:region animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
