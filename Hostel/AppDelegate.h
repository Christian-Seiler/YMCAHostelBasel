//
//  AppDelegate.h
//  Hostel
//
//  Created by Christian Seiler on 12.08.13.
//  Copyright (c) 2013 YCMCA Hostel Basel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setNetworkActivityIndicatorVisible:(BOOL)setVisible;

@end
