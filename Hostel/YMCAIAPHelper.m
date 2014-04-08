//
//  YMCAIAPHelper.m
//  YMCA Basel
//
//  Created by Christian Seiler on 04/02/14.
//  Copyright (c) 2014 YMCA Hostel Basel. All rights reserved.
//

#import "YMCAIAPHelper.h"

@implementation YMCAIAPHelper

+ (YMCAIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static YMCAIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"ymcawine",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}
@end