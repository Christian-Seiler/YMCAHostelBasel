//
//  ImpressumVC.m
//  Hostel
//
//  Created by Christian Seiler on 15.09.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "ImpressumVC.h"

@interface ImpressumVC ()

@property (weak, nonatomic) IBOutlet UINavigationItem *impressumTitle;

@end

@implementation ImpressumVC

@synthesize versionLabel, creditsView, impressumTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *creditsURL = [[NSBundle mainBundle] pathForResource:@"Credits" ofType:@"rtf"];
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *build = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    versionLabel.text = [NSString stringWithFormat:@"Version %@ (%@)", version, build];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:creditsURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:fileURL];
    [creditsView loadRequest:requestObj];
    self.impressumTitle.title = NSLocalizedString(@"Impressum", @"ImpressumTitle");
}

- (IBAction)termsButton:(id)sender {
}

@end
