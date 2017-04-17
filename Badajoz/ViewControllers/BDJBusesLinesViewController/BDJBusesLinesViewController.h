//
//  BDJBusesLinesViewController.h
//  Badajoz
//
//  Created by David Cordero on 29/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJBusesLinesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
