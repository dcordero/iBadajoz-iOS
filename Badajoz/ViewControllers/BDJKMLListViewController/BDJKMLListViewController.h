//
//  BDJKMLListViewController.h
//  Badajoz
//
//  Created by David Cordero on 18/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDJKMLMapViewController.h"

@interface BDJKMLListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *listview;

- (void)setGeometries:(NSArray *)geometries;

@end
