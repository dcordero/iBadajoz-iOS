//
//  BDJContactViewController.h
//  Badajoz
//
//  Created by David Cordero on 16/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDJContact.h"
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>

@interface BDJContactViewController : UIViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithContact:(BDJContact *)contact;

@end
