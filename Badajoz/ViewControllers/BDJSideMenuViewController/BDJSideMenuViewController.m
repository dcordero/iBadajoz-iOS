//
//  BDJSideMenuViewController.m
//  Badajoz
//
//  Created by David Cordero on 23/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJSideMenuViewController.h"
#import "Configuration.h"
#import "UIColor+BadajozColors.h"
#import "BDJSegmentedSwipeViewController.h"
#import "BDJNavigationController.h"
#import "BDJContactsListViewController.h"
#import "BDJMoreInfoViewController.h"
#import "BDJBusesLinesViewController.h"
#import "BDJNewsMainViewController.h"
#import "BDJKMLMainViewController.h"
#import "BDJKMLMapViewController.h"

@interface BDJSideMenuViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation BDJSideMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 155.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 80, 80)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"Badajoz icon"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 40.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 125, 0, 24)];
        label.text = @"iBadajoz";
        label.font = [UIFont fontWithName:@"Helvetica" size:18];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor badajozTintColor];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Private

- (UIView *)headerViewWithTitle:(NSString *)title
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor badajozBaseColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, 0, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor badajozTintColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor badajozTintColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    switch (sectionIndex) {
        case 0:
            return [self headerViewWithTitle:NSLocalizedString(@"Main", @"Title for Main in sidebar")];
            break;
        case 1:
            return [self headerViewWithTitle:NSLocalizedString(@"Transport", @"Title for Transport in sidebar")];
            break;
        default:
            return [self headerViewWithTitle:NSLocalizedString(@"More", @"Title for More in sidebar")];
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    
    return 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *selectedViewController = nil;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                selectedViewController = [[BDJNewsMainViewController alloc] init];
                break;
            case 1:
                selectedViewController = [[BDJContactsListViewController alloc] init];
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                selectedViewController = [[BDJBusesLinesViewController alloc] init];
                break;
            case 1:
                selectedViewController = [[BDJKMLMainViewController alloc] initWithSource:BIBA];
                break;
            case 2:
                selectedViewController = [[BDJKMLMainViewController alloc] initWithSource:HANDICAPTED];
        }
    }
    else if (indexPath.section == 2){
        selectedViewController = [[BDJMoreInfoViewController alloc] init];
    }
    
    BDJNavigationController *navigationController = [[BDJNavigationController alloc] initWithRootViewController:selectedViewController];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    switch (sectionIndex) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[NSLocalizedString(@"News", @"Title for News"),
                            NSLocalizedString(@"Contacts", @"Title for Contacts")];
        cell.textLabel.text = titles[indexPath.row];
    }
    else if (indexPath.section == 1) {
        NSArray *titles = @[NSLocalizedString(@"Tubasa", @"Title for Tubasa"),
                            NSLocalizedString(@"BiBa", @"Title for BiBa"),
                            NSLocalizedString(@"Handicapted parking", @"Title for Handicapted parking"),];
        cell.textLabel.text = titles[indexPath.row];
    }
    else {
        NSArray *titles = @[NSLocalizedString(@"More information", @"Title for More information in sidebar")];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}

@end
