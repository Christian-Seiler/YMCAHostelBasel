//
//  RoomsDetailViewController.h
//  Hostel
//
//  Created by Christian Seiler on 18.08.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomsDetailVC : UIViewController

@property (strong, nonatomic) IBOutlet UINavigationItem *roomName;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (strong, nonatomic) NSString *roomNameString;
@property (strong, nonatomic) NSString *priceLabelString;
@property (strong, nonatomic) NSString *descriptionLabelString;
@property (strong, nonatomic) NSString *roomImageString;

@end
