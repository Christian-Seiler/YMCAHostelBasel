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
@property (nonatomic, strong) IBOutlet UIView *canvas;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingIndicatorLabel;

// contentView's vertical bottom constraint, used to alter the contentView's vertical size when ads arrive
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation ReservationViewController
{
    ADBannerView *_bannerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.reservationTitle.title = NSLocalizedString(@"Reservation", @"Reservation Navigation Title");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadReservationSite];
}


- (void)loadReservationSite {
    _webView.delegate = self;
    NSString *reservationURL = @"http://ex.ymcahostelbasel.ch/v8client";
    NSURL *url = [NSURL URLWithString:reservationURL];
    NSURLRequest *request = [NSURLRequest  requestWithURL:url];
    [self.webView loadRequest:request];
}
# pragma mark - WebView

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.activityIndicator stopAnimating];
    self.loadingIndicatorLabel.hidden = TRUE;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


- (BOOL) connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

#pragma mark - iAd

- (void)layoutAnimated:(BOOL)animated
{
    CGRect contentFrame = self.view.bounds;
    
    // all we need to do is ask the banner for a size that fits into the layout area we are using
    CGSize sizeForBanner = [_bannerView sizeThatFits:contentFrame.size];
    
    // compute the ad banner frame
    CGRect bannerFrame = _bannerView.frame;
    if (_bannerView.bannerLoaded) {
        
        // bring the ad into view
        contentFrame.size.height -= sizeForBanner.height;   // shrink down content frame to fit the banner below it
        bannerFrame.origin.y = contentFrame.size.height;
        bannerFrame.size.height = sizeForBanner.height;
        bannerFrame.size.width = sizeForBanner.width;
        
        // if the ad is available and loaded, shrink down the content frame to fit the banner below it,
        // we do this by modifying the vertical bottom constraint constant to equal the banner's height
        //
        NSLayoutConstraint *verticalBottomConstraint = self.bottomConstraint;
        verticalBottomConstraint.constant = sizeForBanner.height;
        [self.view layoutSubviews];
        
    } else {
        // hide the banner off screen further off the bottom
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        _canvas.frame = contentFrame;
        [_canvas layoutIfNeeded];
        _bannerView.frame = bannerFrame;
    }];
}

- (void)viewDidLayoutSubviews
{
    [self layoutAnimated:[UIView areAnimationsEnabled]];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self layoutAnimated:YES];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"didFailToReceiveAdWithError %@", error);
    [self layoutAnimated:YES];
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    return YES;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
}

@end