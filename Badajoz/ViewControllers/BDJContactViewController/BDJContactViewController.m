//
//  BDJContactViewController.m
//  Badajoz
//
//  Created by David Cordero on 16/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJContactViewController.h"

#import "BDJBackgroundView.h"
#import "BDJNavigationController.h"
#import "BDJAddressAnnotation.h"
#import "BDJContactHeaderViewCell.h"
#import "BDJWebViewController.h"
#import "SVProgressHUD.h"
#import "DTAlertView.h"

typedef NS_ENUM(NSInteger, ContactDetails) {
    ADDRESS,
    PHONE,
    EMAIL,
    FAX,
    WEB
};

@interface BDJContactViewController ()
@property (strong, nonatomic) BDJContact *contact;
@end

@implementation BDJContactViewController

- (id)initWithContact:(BDJContact *)contact
{
    self = [super init];
    if (self) {
        _contact = contact;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showBackgroundView];

}

#pragma mark - Private

- (void)showBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
}

- (NSInteger)sizeOfText:(NSString *)text withFont:(UIFont *)font{
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(304, 150)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return  MAX(rect.size.height, 30);
}

- (void)callContact
{
    DTAlertViewButtonClickedBlock block = ^(DTAlertView *_alertView, NSUInteger buttonIndex, NSUInteger cancelButtonIndex){
        if (buttonIndex == 1) {
            NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",self.contact.phone1];
            NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
            [[UIApplication sharedApplication] openURL:phoneURL];
        }
    };
    
    DTAlertView *alertView = [DTAlertView alertViewUseBlock:block
                                                      title:NSLocalizedString(@"Phone", @"Title in popup to call a contact")
                                                    message:NSLocalizedString(@"Do you want to call the contact?", @"Question to confirm call the contact")
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel button in popup to call a contact")
                                        positiveButtonTitle:NSLocalizedString(@"Sure", @"OK button in popup to call a contact")];
    [alertView showWithAnimation:DTAlertViewAnimationSlideRight];
}

- (void)openMailApp
{
    if ([MFMailComposeViewController canSendMail] ) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        [controller setToRecipients:@[self.contact.email]];
        controller.mailComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
    else {
        NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"mailto:%@?subject=&body=", self.contact.email]];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 0;
    
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        if (self.contact.longitud && self.contact.latitud) {
            BDJContactHeaderViewCell *headerViewCell = [[BDJContactHeaderViewCell alloc] init];
            
            CLLocationCoordinate2D coord = {.latitude =  self.contact.latitud, .longitude =  self.contact.longitud};
            MKCoordinateSpan span = {.latitudeDelta =  0.022, .longitudeDelta =  0.022};
            MKCoordinateRegion region = {coord, span};
            
            
            CLLocationCoordinate2D  ctrpoint;
            ctrpoint.latitude = self.contact.latitud;
            ctrpoint.longitude =self.contact.longitud;
            BDJAddressAnnotation *addAnnotation = [[BDJAddressAnnotation alloc] initWithCoordinate:ctrpoint];
            [headerViewCell.mapView addAnnotation:addAnnotation];
            
            [headerViewCell.mapView setRegion:region];
            headerViewCell.contactName.text = self.contact.name;
            
            return headerViewCell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        CGFloat nameLabelHeight = [self sizeOfText:self.contact.name withFont:[UIFont fontWithName:@"Helvetica" size:19.0]];
        ;
        NSInteger padding = 160 + 8 + 8;
        
        return nameLabelHeight + padding;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
        case ADDRESS:
            cell.textLabel.text = NSLocalizedString(@"Address",
                                                    @"Address label in contact viewer");
            cell.detailTextLabel.text = self.contact.address;
            break;
        case PHONE:
            cell.textLabel.text = NSLocalizedString(@"Phone",
                                                    @"Phone label in contact viewer");
            cell.detailTextLabel.text = self.contact.phone1;
            break;
        case EMAIL:
            cell.textLabel.text = NSLocalizedString(@"Email",
                                                    @"Email label in contact viewer");
            cell.detailTextLabel.text = self.contact.email;
            break;
        case FAX:
            cell.textLabel.text = NSLocalizedString(@"Fax",
                                                    @"Fax label in contact viewer");
            cell.detailTextLabel.text = self.contact.fax;
            break;
        case WEB:
            cell.textLabel.text = NSLocalizedString(@"Web",
                                                    @"Web label in contact viewer");
            cell.detailTextLabel.text = self.contact.web;
    }
    
    if ([cell.detailTextLabel.text isEqualToString:@""]) {
            cell.textLabel.alpha = 0.439216f;
            cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.row) {
        case PHONE:
            [self callContact];
            break;
            
        case WEB:
        {
            NSURL *url = [ [ NSURL alloc ] initWithString:self.contact.web ];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
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
        {
            [self dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"The email was sent successfully", @"Success message when contacting contact by email")];
        }
            break;
        case MFMailComposeResultFailed:
        {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Something went wrong. Please try again in a few minutes.", @"Error message when contacting contact by email")];
        }
            break;
        default:
            break;
    }
}

@end
