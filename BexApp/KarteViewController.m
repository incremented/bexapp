//
//  MapViewController.m
//  BexApp
//
//  Created by Timotheus Jochum on 15/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "KarteViewController.h"
#import "SWRevealViewController.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface KarteViewController ()

@end

@implementation KarteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRevealViewController];
    
    [self setupMapView];
    
    // Add a user tracking button to the toolbar
//    MKUserTrackingBarButtonItem *trackingItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    MKCoordinateRegion region = [self setLocation];
    
    [self setAnnotation:region];
}

// Adds the PanGesture and TapGesture Recognizer to self.view
- (void)setupRevealViewController {
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    }
}

- (void)setupMapView {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8
    [self.locationManager requestWhenInUseAuthorization];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.mapView.showsUserLocation = YES;
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    [buttonItem.customView setTintColor:UIColorFromRGB(0xFD9712)];
    [self.mapView setTintColor:UIColorFromRGB(0x73CFF7)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.toolbar setItems:[NSArray arrayWithObjects:flexibleItem, buttonItem, nil] animated:YES];
    
//    self.navigationItem.rightBarButtonItem = buttonItem;
    
}
////////////////////////////

//Set Location
-(MKCoordinateRegion)setLocation {
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 50.7731779;
    newRegion.center.longitude = 6.106701199999975;
    newRegion.span.latitudeDelta = 0.00725;
    newRegion.span.longitudeDelta = 0.00725;
    
    [self.mapView setRegion:newRegion animated:YES];
    
    return newRegion;
}

//Set Pin
-(void)setAnnotation:(MKCoordinateRegion)region {
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(region.center.latitude, region.center.longitude);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    
    [annotation setCoordinate:coord];
    [annotation setTitle:@"Anwaltskanzlei Bex"];
    [annotation setSubtitle:@"Viktoriastraße 28"];
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
}


- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    
    
 
    // Check authorization status (with class method)
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // User has never been asked to decide on location authorization
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"Requesting when in use auth");
        [self.locationManager requestWhenInUseAuthorization];
    }
    // User has denied location use (either for this app or for all apps
    else if (status == kCLAuthorizationStatusDenied) {
        NSLog(@"Location services denied");
        // Alert the user and send them to the settings to turn on location
    }
  
}

//-(void)setLocationManager:(CLLocationManager *)locationManager
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
