//
//  agbDetailViewController.m
//  Hostel
//
//  Created by Christian Seiler on 28.08.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "agbDetailVC.h"

@interface agbDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UILabel *agbLabel;

@end

@implementation agbDetailVC

@synthesize agbTitle;
@synthesize scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.agbTitle.title = [self.agbTitleString description];
    [self setText];
}

- (void)setText {
    UILabel *agbTextLabel = [[UILabel alloc] init];
    [self.scrollView addSubview:agbTextLabel];
    agbTextLabel.text = [self.agbTextString description];
}

@end
