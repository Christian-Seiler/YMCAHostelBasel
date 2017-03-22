//
//  ReservationViewController.h
//  YMCA Basel
//
//  Created by Christian Seiler on 09.11.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface ReservationViewController : UIViewController <ADBannerViewDelegate, UIWebViewDelegate>

@property (nonatomic) NSURL *url;
- (BOOL)connected;

@end
