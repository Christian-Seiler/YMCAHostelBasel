//
//  DetailMapVC.m
//  YMCA Basel
//
//  Created by Christian Seiler on 09.11.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "DetailMapVC.h"
#import "MapViewAnnotation.h"


@interface DetailMapVC ()

@property (nonatomic) BOOL needUpdateRegion;

@end

@implementation DetailMapVC

@synthesize detailMapView;

- (void)viewDidLoad {
    self.needUpdateRegion = YES;
	// Set some coordinates for our position
	CLLocationCoordinate2D hostel;
	hostel.latitude = (double) 47.5432964;
	hostel.longitude = (double) 7.585847;

    CLLocationCoordinate2D airport;
	airport.latitude = (double) 47.5432964;
	airport.longitude = (double) 7.585847;
    
    CLLocationCoordinate2D trainstation;
	trainstation.latitude = (double) 47.5432964;
	trainstation.longitude = (double) 7.585847;
    
	// Add the annotation to our map view
	MapViewAnnotation *hostelAnnotation = [[MapViewAnnotation alloc] initWithTitle:(NSLocalizedString(@"YMCAAnnotation", @"YMCA Hostel Basel"))
                                                                  andCoordinate:hostel];
    MapViewAnnotation *airportAnnotation = [[MapViewAnnotation alloc] initWithTitle:(NSLocalizedString(@"AirportAnnotation", @"Airport Basel"))
                                                                  andCoordinate:airport];
    MapViewAnnotation *trainstationAnnotation = [[MapViewAnnotation alloc] initWithTitle:(NSLocalizedString(@"TrainstationAnnotation", @"Trainstation SBB"))
                                                                  andCoordinate:trainstation];
    
	[self.detailMapView addAnnotation:hostelAnnotation];
	[self.detailMapView addAnnotation:airportAnnotation];
	[self.detailMapView addAnnotation:trainstationAnnotation];
    self.detailMapView.region = MKCoordinateRegionMakeWithDistance(hostel, 2000000, 2000000);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.needUpdateRegion) [self updateRegion];
}

#pragma mark Map behaviour

- (void)mapViewWillStartLoadingMap:(MKMapView *)detailMapView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)detailMapView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)detailMapView withError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"ERROR: %@", error);
    // display message, that Map couldn't load
}

- (void)updateRegion {
    self.needUpdateRegion = NO;
    
    //if showAnnotations:animated: is available, use it...
    if ([mapView respondsToSelector:@selector(showAnnotations:animated:)])
    {
        [self.detailMapView showAnnotations:mapView.annotations animated:YES];
        return;
    }
}


@end
