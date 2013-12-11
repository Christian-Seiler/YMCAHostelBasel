//
//  ReservationViewController.m
//  YMCA Basel
//
//  Created by Christian Seiler on 09.11.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "ReservationViewController.h"

@interface ReservationViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *reservationTitle;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ReservationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.reservationTitle.title = NSLocalizedString(@"Reservation", @"Reservation Navigation Title");

    NSString *reservationURL = @"http://ex.ymcahostelbasel.ch/v8client";
    NSURL *url = [NSURL URLWithString:reservationURL];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    [self.webView loadRequest:request];
}

@end