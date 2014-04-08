//
//  RoomsViewController.m
//  Hostel
//
//  Created by Christian Seiler on 17.08.13.
//  Copyright (c) 2013 YMCA Hostel Basel. All rights reserved.
//

#import "RoomsViewController.h"
#import "RoomsDetailVC.h"

@interface RoomsViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *roomsTitle;

@property (strong) NSArray *room;

@end

@implementation RoomsViewController

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
        
    self.room = [[NSArray alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"room" withExtension:@"plist"]];
    self.roomsTitle.title = NSLocalizedString(@"Rooms", @"roomsTitle");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.room count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.room[section][@"room"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"dorms", @"dormsSectionHeader");
            break;
        case 1:
            sectionName = NSLocalizedString(@"private Rooms", @"privateRoomsSectionHeader");
            break;
        case 2:
            sectionName = NSLocalizedString(@"studios", @"studiosSectionHeader");
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"roomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    cell.textLabel.text = self.room[indexPath.section][@"room"][indexPath.row][@"name"];
    cell.detailTextLabel.text = self.room[indexPath.section][@"room"][indexPath.row][@"price"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"setRoom:"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *roomDetail = self.room[indexPath.section][@"room"][indexPath.row][@"name"];
        NSString *priceDetail = self.room[indexPath.section][@"room"][indexPath.row][@"price"];
        NSString *info = self.room[indexPath.section][@"room"][indexPath.row][@"info"];
        NSString *image = self.room[indexPath.section][@"room"][indexPath.row][@"image"];
        
        RoomsDetailVC *destViewController = segue.destinationViewController;
        
        destViewController.roomNameString = roomDetail;
        destViewController.priceLabelString = priceDetail;
        destViewController.descriptionLabelString = info;
        destViewController.roomImageString = image;
    }
}

@end