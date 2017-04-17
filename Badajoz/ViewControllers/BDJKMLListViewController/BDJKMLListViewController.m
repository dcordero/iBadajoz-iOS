//
//  BDJKMLListViewController.m
//  Badajoz
//
//  Created by David Cordero on 18/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJKMLListViewController.h"
#import "BDJBackgroundView.h"
#import "KML.h"
#import "KML+MapKit.h"
#import "BDJKMLDetailsViewController.h"
#import "WeakifyStrongify.h"
#import "UIColor+BadajozColors.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface BDJKMLListViewController ()

@property (nonatomic) NSArray *geometries;

@end

@implementation BDJKMLListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self showBackgroundView];
}

- (void)setGeometries:(NSArray *)geometries
{
    _geometries = geometries;
    [self.listview reloadData];
}

#pragma mark - Private

- (void)showBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KMLAbstractGeometry *geometry;
    geometry = self.geometries[indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    KMLPlacemark *placemark = geometry.placemark;
    cell.textLabel.text = placemark.name;
    [cell.textLabel setFont: [UIFont fontWithName:@"Helvetica" size:18.0f]];
    [cell.textLabel setTextColor:[UIColor badajozTintColor]];
    cell.detailTextLabel.text = placemark.snippet;
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.geometries.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    KMLAbstractGeometry *geometry;
    geometry = self.geometries[indexPath.row];
    BDJKMLDetailsViewController *viewController = [[BDJKMLDetailsViewController alloc] init];
    if (viewController) {
        viewController.geometry = geometry;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
