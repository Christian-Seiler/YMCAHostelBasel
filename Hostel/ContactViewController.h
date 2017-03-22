//
//  ContactViewController.h
//  Hostel
//
//  Created by Christian Seiler on 12.08.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MapKit/MapKit.h>
#import "MessageUI/MessageUI.h"
#import "Reachability.h"
#import <iAd/iAd.h>


@interface ContactViewController : UIViewController<UIAlertViewDelegate, MKMapViewDelegate, ADBannerViewDelegate>
{
    MKMapView *mapView;
}

- (IBAction)mailButton:(id)sender;
- (IBAction)callButton:(id)sender;
- (BOOL)connected;

@end
