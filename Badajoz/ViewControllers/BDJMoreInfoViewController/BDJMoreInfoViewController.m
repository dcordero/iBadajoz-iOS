//
//  BDJMoreInfoViewController.m
//  Badajoz
//
//  Created by David Cordero on 20/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJMoreInfoViewController.h"

#import "UIColor+BadajozColors.h"
#import "BDJBackgroundView.h"
#import "BDJNavigationController.h"
#import "BDJRateAppView.h"
#import "Configuration.h"
#import "SVProgressHUD.h"
#import "BDJWebViewController.h"
#import "BDJCustomHeaderGroupViewCell.h"

#define SectionsInMoreInfo 3;

#define RowsInMainSection 1;
#define RowsInSocialNetworksSection 2;
#define RowsInContactSection 1;

typedef NS_ENUM(NSInteger, SectionType) {
    MainSection,
    SocialNetworksSection,
    ContactSection
};

@implementation BDJMoreInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTitle];
    [self configureNavigationBar];
    [self showBackgroundView];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return SectionsInMoreInfo;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case MainSection:
            return RowsInMainSection;
            break;
        case SocialNetworksSection:
            return RowsInSocialNetworksSection;
        case ContactSection:
            return RowsInContactSection;
    }
    return 0;
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == MainSection) {
        BDJRateAppView *rateAppView = [[BDJRateAppView alloc] init];
        return rateAppView;
    }
    else {
        BDJCustomHeaderGroupViewCell *headerViewCell = [[BDJCustomHeaderGroupViewCell alloc] init];
        
        switch (section) {
            case SocialNetworksSection:
                headerViewCell.changeHereLabel.text = NSLocalizedString(@"Social networks", @"Social networks in More Information");
                break;
            case ContactSection:
                headerViewCell.changeHereLabel.text = NSLocalizedString(@"Contact support", @"Contact support in More Information");
        }
        
        return headerViewCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == MainSection) {
        return 120;
    }
    return 50;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"teacherCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == MainSection) {
        cell.imageView.image = [UIImage imageNamed:@"Rate Us icon"];
        cell.textLabel.text = NSLocalizedString(@"Rate us on AppStore", @"Rate us on AppStore in More Information");
    }
    
    else if (indexPath.section == SocialNetworksSection) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"Facebook icon"];
                cell.textLabel.text = NSLocalizedString(@"Badajoz on Facebook", @"Facebook in More Information");
                break;
            case 1:
                cell.imageView.image = [UIImage imageNamed:@"Twitter icon"];
                cell.textLabel.text = NSLocalizedString(@"Badajoz on Twitter", @"Twitter in More Information");
                break;
        }
    }
    
    else if (indexPath.section == ContactSection) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image = [UIImage imageNamed:@"Contact Support"];
                cell.textLabel.text = NSLocalizedString(@"Contact support", @"Contact support email in More Information Information");
                break;
        }
    }
    
    [cell.textLabel setTextColor:[UIColor badajozTintColor]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == MainSection) {
        [self openAppStore];
    }
    else if (indexPath.section == SocialNetworksSection) {
        NSString *url = @"";
        if (indexPath.row == 0) {
            url = @"https://www.facebook.com/aytobadajoz";
        }
        else {
            url = @"https://twitter.com/aytodebadajoz";
        }
        BDJWebViewController *webViewController = [[BDJWebViewController alloc] initWithURL:url];
        [self.navigationController pushViewController:webViewController animated:YES];
    }
    else if (indexPath.section == ContactSection) {
        [self openMailApp];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MFMailComposeResultSaved:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MFMailComposeResultSent:
            [self dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Thank you for your feedback", @"Thank you message for your feedback in contact support")];
            break;
        case MFMailComposeResultFailed:
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Something went wrong. Please try again in a few minutes.", @"Error message for error in contact support")];
            break;
        default:
            break;
    }
}

#pragma mark - Private

- (void)openAppStore
{
    NSURL *appStoreUrl = [NSURL URLWithString:RATE_APP_URL];
    [[UIApplication sharedApplication] openURL:appStoreUrl];
}

- (void)openMailApp
{
    if ([MFMailComposeViewController canSendMail] ) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [controller setToRecipients:@[CONTACT_SUPPORT_MAIL]];
        [controller setSubject:NSLocalizedString(@"Badajoz for iOS", @"Subject for contact support email")];
        controller.mailComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else {
        NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"mailto:%@?subject=&body=", CONTACT_SUPPORT_MAIL]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)setupTitle
{
    [self setTitle:NSLocalizedString(@"More Info", @"Title for More Info")];
}

- (void)configureNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu icon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(BDJNavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

- (void)showBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
}

@end
