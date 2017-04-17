//
//  BDJBusStopViewController.h
//  Badajoz
//
//  Created by David Cordero on 28/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDJParada.h"
#import "BDJLinea.h"

@interface BDJBusStopViewController : UIViewController <UITableViewDataSource, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (id)initWithParada:(BDJParada *)parada inLine:(BDJLinea *)linea;

@end
