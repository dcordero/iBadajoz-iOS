//
//  BDJNewsListViewController.h
//  Badajoz
//
//  Created by David Cordero on 08/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BDJNewsFeed) {
    BDJNewsFeedFlash,
    BDJNewsFeedSpecials,
    BDJNewsFeedJobs
};

@interface BDJNewsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic)BDJNewsFeed feed;

- (id)initWithFeed:(BDJNewsFeed)feed;

@end
