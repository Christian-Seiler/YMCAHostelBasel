//
//  MapViewAnnotation.m
//  Hostel
//
//  Created by Christian Seiler on 17.08.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

@synthesize title, coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	title = ttl;
	coordinate = c2d;
    
	return self;
}
@end