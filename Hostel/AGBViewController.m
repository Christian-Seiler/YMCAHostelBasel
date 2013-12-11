//
//  AGBViewController.m
//  Hostel
//
//  Created by Christian Seiler on 28.08.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "AGBViewController.h"
#import "agbDetailVC.h"

@interface AGBViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *agbTitle;
@property (strong) NSArray *agb;

@end

@implementation AGBViewController

@synthesize tableViews;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.agb = [[NSArray alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"agb" withExtension:@"plist"]];
    self.agbTitle.title = NSLocalizedString(@"Terms & Conditions", @"agbTitle");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.agb count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.agb[section][@"article"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Terms", @"termsSectionHeader");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Houserules", @"rulesRoomsSectionHeader");
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"agbCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.agb[indexPath.section][@"article"][indexPath.row][@"title"];
    cell.detailTextLabel.text = self.agb[indexPath.section][@"article"][indexPath.row][@"text"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setAGB:"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *agbTitle = self.agb[indexPath.section][@"article"][indexPath.row][@"title"];
        NSString *agbText = self.agb[indexPath.section][@"article"][indexPath.row][@"text"];
       
        agbDetailVC *destViewController = segue.destinationViewController;
        
        destViewController.agbTitleString = agbTitle;
        destViewController.agbTextString = agbText;
    }
}

@end