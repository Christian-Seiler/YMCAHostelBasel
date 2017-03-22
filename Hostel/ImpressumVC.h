//
//  ImpressumVC.h
//  Hostel
//
//  Created by Christian Seiler on 15.09.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImpressumVC : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)termsButton:(id)sender;
@end
