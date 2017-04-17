//
//  BDJPieceOfNewsViewController.m
//  Badajoz
//
//  Created by David Cordero on 12/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJPieceOfNewsViewController.h"

#import "BDJBackgroundView.h"
#import "NSString+HTML.h"
#import "DTAlertView.h"

@interface BDJPieceOfNewsViewController ()

@property (strong, nonatomic)BDJRSSItem *rssItem;

@end

@implementation BDJPieceOfNewsViewController

- (id)initWithRSSItem:(BDJRSSItem *)rssItem
{
    self = [super init];
    if (self) {
        _rssItem = rssItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.bodyWebView setDelegate:self];
    [self loadPieceOfNews];
    [self showNewsBackgroundView];
    [self setupNavigationBar];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

#pragma mark - UIWebViewDelegate

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

#pragma mark - Private

- (void)loadPieceOfNews
{
    NSString *rssItemHtml = [NSString stringWithFormat:@"<html> \n"
                             "<head> \n"
                             "<style type=\"text/css\"> \n"
                             "body {font-family: \"Helvetica\"; font-size: 13;}\n"
                             "h4 {font-family: \"Helvetica\"; font-size: 18; color: #156EFB;}\n"
                             "</style> \n"
                             "</head> \n"
                             "<body><h4>%@</h4>\n\n <center> %@ </center> \n\n %@</body> \n"
                             "</html>",
                             self.rssItem.title,
                             self.rssItem.thumbnailUrl ? [NSString stringWithFormat:@"<img src=\"%@\"/>", self.rssItem.thumbnailUrl] : @"",
                             self.rssItem.descriptionText];
    
    [self.bodyWebView loadHTMLString:rssItemHtml baseURL:nil];
}

- (void)showNewsBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
    
}

- (void)setupNavigationBar
{
    self.navigationItem.rightBarButtonItems = @[[self barButtonItemForShareNews],[self barButtonItemForOpenInSafari]];
}

- (UIBarButtonItem *)barButtonItemForOpenInSafari
{
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Browser icon"]
                                            style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(openInSafariButtonPressed)];

}

- (UIBarButtonItem *)barButtonItemForShareNews
{
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Share icon"]
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(shareNewsButtonPressed)];
}

- (void)openInSafariButtonPressed
{
    DTAlertViewButtonClickedBlock block = ^(DTAlertView *_alertView, NSUInteger buttonIndex, NSUInteger cancelButtonIndex){
        if (buttonIndex == 1) {
            NSURL *url = [ [ NSURL alloc ] initWithString:self.rssItem.link ];
            [[UIApplication sharedApplication] openURL:url];
        }
    };
    
    DTAlertView *alertView = [DTAlertView alertViewUseBlock:block
                                                      title:NSLocalizedString(@"Link", @"Title in popup to open link in safari")
                                                    message:NSLocalizedString(@"Are you sure you want to open this link in Safari?", @"Question in popup to open link in safari")
                                          cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel button in popup to open link in safari")
                                        positiveButtonTitle:NSLocalizedString(@"Sure", @"OK button in popup to open link in safari")];
    [alertView showWithAnimation:DTAlertViewAnimationSlideRight];
}

- (void)shareNewsButtonPressed
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *sharingMessage = NSLocalizedString(@"Look at this piece of news that I just saw on aytobadajoz.es  ", @"Message when sharing a piece of news to e.g social media");
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[sharingMessage, self.rssItem.link] applicationActivities:nil];
        activityController.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypeAirDrop];
        
        [self presentViewController:activityController animated:YES completion:nil];

    });
}

@end
