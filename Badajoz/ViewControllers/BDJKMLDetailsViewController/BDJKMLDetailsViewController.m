//
//  BDJKMLDetailsViewController.m
//  Badajoz
//
//  Created by David Cordero on 17/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJKMLDetailsViewController.h"

#import <MapKit/MapKit.h>
#import "KMLAbstractGeometry+MapKit.h"
#import "MKShape+KML.h"
#import "BDJBackgroundView.h"

@implementation BDJKMLDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self showBackgroundView];
    [self setupTitle];
    [self updateDetails];
}

#pragma mark - Private

- (void)showBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
}

- (void)setupTitle
{
    self.title = NSLocalizedString(@"Details", @"Title for KML Details");
}

- (void)updateDetails
{
    KMLPlacemark *placemark = self.geometry.placemark;
    
    NSString *htmlString = [NSString stringWithFormat:
                            @"<html>"
                            "<head>"
                            "<style type=\"text/css\">"
                            "body { font-family: \"Helvetica\"; font-size: 13; }"
                            "img { height: auto; width:100%%; padding-top:5px; }"
                            "h4 {font-family: \"Helvetica\"; font-size: 18; color: #156EFB;}"
                            "</style>"
                            "</head>"
                            "<body>"
                            "<h4>%@</h4>"
                            "%@"
                            "</body>"
                            "</html>"
                            , placemark.name ? placemark.name : @""
                            , placemark.descriptionValue ? placemark.descriptionValue : @""];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

@end
