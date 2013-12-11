//
//  RoomsDetailViewController.m
//  Hostel
//
//  Created by Christian Seiler on 18.08.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "RoomsDetailVC.h"
#import "RoomsViewController.h"

@interface RoomsDetailVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation RoomsDetailVC

@synthesize roomName;
@synthesize priceLabel;
@synthesize descriptionTextView;
@synthesize roomImageString;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *price = [self.priceLabelString description];
    self.roomName.title = [self.roomNameString description];
    self.priceLabel.text = [[NSLocalizedString(@"Price", @"price") stringByAppendingString:@": "] stringByAppendingString:price];
    
    NSString *roomDescription = [self.descriptionLabelString description];
    self.descriptionTextView.text = roomDescription;
    
    [self setImage];
    [self.scrollView addSubview:_imageView];
}

- (void)setImage {
    if (self.scrollView) {
        NSString *imageName = [self.roomImageString description];
        NSURL *imageURL = [[NSBundle mainBundle] URLForResource:imageName withExtension:@"png"];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
        
        
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            self.scrollView.zoomScale = 1.0;
            self.scrollView.contentSize = image.size;
            self.imageView.image = image;
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        } else {
            NSLog(@"no image");
        }
    }
}

- (UIImageView *)imageView {
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
    NSLog(@"imageView");
}

@end
