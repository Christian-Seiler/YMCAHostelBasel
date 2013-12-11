//
//  DetailMapVC.h
//  YMCA Basel
//
//  Created by Christian Seiler on 09.11.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DetailMapVC : UIViewController

{
    MKMapView *mapView;
    
}

@property (strong, nonatomic) IBOutlet MKMapView *detailMapView;

@end
