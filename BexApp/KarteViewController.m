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

@interface KarteViewController () {

    // Presents the pin of Bex_Location
    MKPointAnnotation *pinAnnotation;

    UIColor *orange;
    UIColor *white;
    UIColor *blue;
}

@end

@implementation KarteViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRevealViewController];

    orange = UIColorFromRGB(0xFD9712);
    white = UIColorFromRGB(0xFFFFFF);
    blue = UIColorFromRGB(0x73CFF7);
    
    [self setupMapView];
    
    pinAnnotation = [self setAnnotation:[self setLocation]];
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

// Setup mapView (includes mapView.delgate = self) and locationManger asked for authorization (includes locationManager.delegate = self)
- (void)setupMapView {
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8
    [self.locationManager requestWhenInUseAuthorization];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.mapView.delegate = self;
    
    // Create segmentedControlBarButtonItem
    UIBarButtonItem *segmentedControlButtonItem = [self createSegmentedControlBarButtonItem];
    
    // Tracking button for currentLocation
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    //Auskommentieren, wenn updateLocation an!!!
    self.mapView.showsUserLocation = YES;
    
    // Set button color
    [buttonItem.customView setTintColor:orange];
    
    // Set currentLocation point color (and all other items of mapView)
    [self.mapView setTintColor:blue];
    
    // Creates flexibleItem to put button on right side of navigationNar
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // Put the button in navigationBar Array
    [self.toolbar setItems:[NSArray arrayWithObjects:segmentedControlButtonItem, flexibleItem, buttonItem,  nil] animated:YES];
}

//Set Bex_Location
-(MKCoordinateRegion)setLocation {
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 50.7731779;
    newRegion.center.longitude = 6.106701199999975;
    newRegion.span.latitudeDelta = 0.00725;
    newRegion.span.longitudeDelta = 0.00725;
    
    // Set the region of mapView --> Bex_Location
    [self.mapView setRegion:newRegion animated:YES];
    
    // return to set pinAnnotation
    return newRegion;
}

//Set MKPointAnnotation and add to mapView
-(MKPointAnnotation*)setAnnotation:(MKCoordinateRegion)region {
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(region.center.latitude, region.center.longitude);
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    
    [annotation setCoordinate:coord];
    [annotation setTitle:@"Anwaltskanzlei Bex"];
    [annotation setSubtitle:@"Viktoriastraße 28 , 52066 Aachen"];
    [self.mapView addAnnotation:annotation];
    [self.mapView selectAnnotation:annotation animated:YES];
    return annotation;
}

// Returns the SegmentedControlBarButtonItem
- (UIBarButtonItem *) createSegmentedControlBarButtonItem{
    
    // Segment Names
    NSArray *itemArray = [NSArray arrayWithObjects: @"Standard", @"Hybrid", @"Satellit", nil];
    
    // Create SegmentControl from Names
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:itemArray];

    // Set Color to orange
    segmentControl.tintColor = orange;
    
    // Set Default Selected Segment
    segmentControl.selectedSegmentIndex = 0;
    
    // Add Delegate und setMapType as Target Function
    [segmentControl addTarget:self action:@selector(setMapType:) forControlEvents:UIControlEventValueChanged];
    
    // Create UIBarButton item with View from our Segment Control
    UIBarButtonItem *segmentedControlButtonItem = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)segmentControl];
    
    return segmentedControlButtonItem;
}


// Create MKDirectionResponse with route from currentLocation to Bex_Location
-(void)direction {
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    // Create MKPlacemark with Bex_Location
    MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:pinAnnotation.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]];
    
    // Create MKPlacemark with currentLocation
    MKPlacemark *selfLocation = [[MKPlacemark alloc] initWithCoordinate:self.locationManager.location.coordinate addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil]];
    
    // Create MKMapItem with both placemarks
    MKMapItem *bexLocation = [[MKMapItem alloc] initWithPlacemark:place];
    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:selfLocation];
    
    // create request for MKDirections
    [request setSource:currentLocation];
    [request setDestination:bexLocation];
    [request setTransportType:MKDirectionsTransportTypeAny]; // This can be limited to automobile and walking directions.
    [request setRequestsAlternateRoutes:YES]; // Gives you several route options.
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    // Handle the response
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (!error) {
            
            // --Get fastest route
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance"
                                                         ascending:YES];
            //Get the routes array sorted by distance
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedRoutes;
            sortedRoutes = [response.routes sortedArrayUsingDescriptors:sortDescriptors];
            
            //The fastest route is the one at index 0 of the sorted array
            MKRoute * fastestRoute = [sortedRoutes objectAtIndex:0];
            
            // Draws the route
            [self.mapView addOverlay:fastestRoute.polyline level:MKOverlayLevelAboveRoads];

/* //Creates all routes on map
            // For every route in response
            for (MKRoute *route in [response routes]) {
             

            // Draws the route above roads, but below labels
            [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
                
                // You can also get turn-by-turn steps, distance, advisory notices, ETA, etc by accessing various route properties.
                for(MKRouteStep * step in route.steps){
                    NSLog(@"Steps %@ \n", step.instructions);
                }
                
            }
*/
        }else {
            NSLog(@"Error %@", error.description);
        }
    }];
    
    // Zoom to currentLocation
    
    CLLocationCoordinate2D loc = self.locationManager.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    
    [self.mapView setRegion:region animated:YES];
    
    // Focus userLocation !! Zoomt immer wieder zum User - TODO: Wenn route gestartet wird !!
//    self.mapView.showsUserLocation = YES;
}

// Handle the seqmented control for mapType
- (IBAction)setMapType:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}

// Old method of Timo J.
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

#pragma delegates

// Set AnnotationView
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        // Try to dequeue an existing pin view first.
        //**Könnten eine eigenes View Objekt erstellen.**
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            // Bex_Orange for pin
            pinView.pinTintColor = orange;
            pinView.animatesDrop = YES;
            // Shows info button in AnnotationView
            
            
            UIButton *navigationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 24)];
            
            
            UIImage *navigationButtonImage = [UIImage imageNamed:@"NavigationIcon"];
            
            
            [navigationButton setImage:navigationButtonImage forState:UIControlStateNormal];
            
            
//            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            
            pinView.rightCalloutAccessoryView = navigationButton;
            pinView.canShowCallout = YES;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}

// Handle the event of MKAnnotationView button click
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    // Starts route to BexLocation
//    [self direction];
    
    NSString *mapsURL = [NSString stringWithFormat:@"http://maps.apple.com/?daddr=Viktoriastrasse+28+52066+Aachen"];
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:mapsURL]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mapsURL]];
    }else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Navigation nicht möglich"
                                                                       message:@"Auf diesem Gerät wird die Navigation leider nicht unterstützt."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

// Overlay routes on mapView
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        // Set route color Bex_Blue
        routeRenderer.strokeColor = blue;
        return routeRenderer;
    }
    else return nil;
}

/*
// Focus userLocation when showUserLocation = YES !! Zoomt immer wieder zum User - TODO: Wenn route gestartet wird !!
- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
}
*/

#pragma mark Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
