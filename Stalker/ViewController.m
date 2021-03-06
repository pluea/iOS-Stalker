//
//  ViewController.m
//  Stalker
//
//  Created by Keisuke Yamaguchi on 2014/12/25.
//  Copyright (c) 2014年 Keisuke Yamaguchi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property CLLocationManager* locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CLLocationManager locationServicesEnabled]) {
        [self startStandardUpdates];
    }else {
        
    }
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startStandardUpdates {
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLDistanceFilterNone;
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 1; // meters
    _locationManager.pausesLocationUpdatesAutomatically = YES;
    [_locationManager startUpdatingLocation];
    [_locationManager requestAlwaysAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation* location = [locations lastObject];
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);

    NSMutableArray *locationList = [[[NSUserDefaults standardUserDefaults]objectForKey:@"locationList"] mutableCopy];
    if (!locationList) {
        locationList = [[NSMutableArray alloc]init];
    }
    [locationList addObject:@{@"lat":[NSNumber numberWithDouble:(double)location.coordinate.latitude],
                            @"lon":[NSNumber numberWithDouble:(double)location.coordinate.longitude]}];
    
    [[NSUserDefaults standardUserDefaults]setObject:locationList forKey:@"locationList"];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

@end
