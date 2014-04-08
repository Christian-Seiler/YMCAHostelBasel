//
//  ContactViewController.m
//  Hostel
//
//  Created by Christian Seiler on 12.08.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "ContactViewController.h"
#import "MapViewAnnotation.h"
#import "DetailMapVC.h"

@interface ContactViewController ()

@property (nonatomic) BOOL needUpdateRegion;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (retain, nonatomic) UIView *rightCalloutAccessoryView;
@property(strong, nonatomic) id<MFMailComposeViewControllerDelegate> mailComposeDelegate;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ContactViewController

@synthesize mapView;

#pragma mark - viewControllerLifeCycle
- (void)viewDidLoad {
    self.needUpdateRegion = YES;
    
    // Set some coordinates for our position
	CLLocationCoordinate2D location;
	location.latitude = (double) 47.5432964;
	location.longitude = (double) 7.585847;
    
	// Add the annotation to our map view
	MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:@"YMCA Hostel Basel"
                                                                  andCoordinate:location];
    
	[self.mapView addAnnotation:newAnnotation];
    self.mapView.region = MKCoordinateRegionMakeWithDistance(location, 500000, 500000);
    
    NSString *deviceType = [UIDevice currentDevice].model;
    if (![deviceType isEqualToString:@"iPhone"]) {
        [self.callButton removeFromSuperview];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
        if (self.needUpdateRegion) [self updateRegion];
}

- (BOOL) connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

#pragma mark - MapView Behahiour

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"Fail Loading");
    self.needUpdateRegion = NO;
    
   if ([[NSString stringWithFormat:@"%ld", (long)error.code] isEqualToString:@"-204"]) {
       NSString *alertCode = [NSString stringWithFormat:@" (%ld)", (long)error.code];
       NSLog(@"No Internet Connection%@", alertCode);
       
       // display message, that Map couldn't load
       NSString *alertMessage = NSLocalizedString(@"NetworkErrorMessage", @"No Internet available");
       
       UIAlertView *MapViewNetworkError = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NetworkError", @"MapView Networkerror")
                                                                      message:[[NSString stringWithString:alertMessage] stringByAppendingString:alertCode]
                                                                     delegate:self
                                                            cancelButtonTitle:NSLocalizedString(@"AlertOK", @"Ok - Alerts")
                                                            otherButtonTitles:nil];
       [MapViewNetworkError isVisible];
       [MapViewNetworkError show];
   }
}

- (void)updateRegion {
    self.needUpdateRegion = NO;
    
    //if showAnnotations:animated: is available, use it...
    if ([mapView respondsToSelector:@selector(showAnnotations:animated:)])
    {
        [self.mapView showAnnotations:mapView.annotations animated:YES];
        return;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier: @"Show Map" sender:view];
}

#pragma mark - mail Button

- (IBAction)mailButton:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        [self displayMailComposerSheet];
    }
    else
    {
        UIAlertView *configuremail = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"configureMail", @"Configure Mail")
                                                           message:NSLocalizedString(@"configureMailMessage.", @"You need configure your Mail.")
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"AlertBack", @"OK - Mailing configure")
                                                 otherButtonTitles: nil];
        [configuremail show];
    }
}

- (void)displayMailComposerSheet {
	MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
	mailer.mailComposeDelegate = (id)self;
	
	[mailer setSubject:@"Mail to YMCA Hostel Basel"];
	
// Set up recipients
	[mailer setToRecipients:[NSArray arrayWithObject:@"info@ymcahostelbasel.ch"]];
	
// Fill out the email body text
	NSString *emailBody = @"Text Sample for an eMail to YMCA Hostel Basel!";
	[mailer setMessageBody:emailBody isHTML:NO];
    
	[self presentViewController:mailer animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	switch (result)
	{
		default:
			break;
	}
	[self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - call Button

- (IBAction)callButton:(id)sender {
    NSString *deviceType = [UIDevice currentDevice].model;
    if ([deviceType isEqualToString:@"iPhone"])
    {
        UIAlertView *callmessage = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Call Hostel", @"Call Hostel")
                                                              message:@"+41 61 361 73 09"
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"CancelCall", @"Cancel")
                                                    otherButtonTitles:NSLocalizedString(@"Call", @"Call Hostel"), nil];
        [callmessage show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+41613617309"]];
    }
}

@end