//
//  BDJBusLineViewController.h
//  Badajoz
//
//  Created by David Cordero on 23/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDJLinea.h"

@interface BDJBusLineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithLine:(BDJLinea *)linea;

@end
