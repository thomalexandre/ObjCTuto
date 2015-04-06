//
//  ViewController.m
//  Where Am I
//
//  Created by Alexandre THOMAS on 31/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"
@import CoreLocation;


@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *headingLabel;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geoCoder;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(startLocationUpdates)];
    self.navigationItem.rightBarButtonItem = startButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            [self.locationManager requestWhenInUseAuthorization];
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = 10.0; //10 meters
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.geoCoder = [[CLGeocoder alloc] init];
            self.navigationItem.rightBarButtonItem.enabled = YES;
            break;
            
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Actions

- (IBAction)startLocationUpdates
{
    NSLog(@"We start to track you :))");
    
    self.navigationItem.rightBarButtonItem = nil;
    
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:self action:@selector(stopLocationUpdates)];
    self.navigationItem.rightBarButtonItem = stopButton;
    [self.locationManager startUpdatingLocation];
    
}

- (IBAction)stopLocationUpdates
{
    NSLog(@"We stop :))");
     self.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *startButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(startLocationUpdates)];
    self.navigationItem.rightBarButtonItem = startButton;
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - LocationCoreLocationDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
//        case kCLAuthorizationStatusNotDetermined:
//            self.locationManager = [[CLLocationManager alloc] init];
//            self.locationManager.delegate = self;
//            [self.locationManager requestWhenInUseAuthorization];
//            break;
    
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            //do something here to inform the user
            NSLog(@"You are not authorized");
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            //self.locationManager = [[CLLocationManager alloc] init];
            //self.locationManager.delegate = self;
            self.locationManager.distanceFilter = 10.0; //10 meters
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            self.navigationItem.rightBarButtonItem.enabled = YES;
            self.geoCoder = [[CLGeocoder alloc] init];
            
            
            // Start heading updates.
            if ([CLLocationManager headingAvailable]) {
                self.locationManager.headingFilter = 5;
                [self.locationManager startUpdatingHeading];
            }
            
            break;
            
            
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0)
        return;
    
    self.headingLabel.text = [NSString stringWithFormat:@"Mag:%f true:%f", newHeading.magneticHeading, newHeading.trueHeading];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"I know where you are ");
    
    CLLocation *userLocation = [locations lastObject];
    
    self.locationLabel.text = [NSString stringWithFormat:@"lat:%f lon:%f", userLocation.coordinate.latitude, userLocation.coordinate.longitude];
    
    [self.geoCoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(placemarks.count > 0 && error == nil) {
            
            CLPlacemark *placemark = placemarks[0];
            NSLog(@"%@", placemark);
            
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@, %@ %@ %@", placemark.subThoroughfare, placemark.thoroughfare, placemark.locality, placemark.administrativeArea, placemark.postalCode];
            
        } else {
            if(error) {
                NSLog(@"%@ %@", error, [error localizedDescription]);
                //exit(-1); // JUST CRASH FOR DEBUGGING
            }
        }
        
    }];
}


@end
