//
//  BDJNewsMainViewController.m
//  Badajoz
//
//  Created by David Cordero on 30/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJNewsMainViewController.h"

@implementation BDJNewsMainViewController

- (void)setupTitle
{
    [self setTitle:NSLocalizedString(@"News", @"Title for News")];
}

- (NSArray *)toolbarElements
{
    return @[ NSLocalizedString(@"Flash", @"Title for flash news in toolbar"),
              NSLocalizedString(@"Specials", @"Title for flash specials in toolbar"),
              NSLocalizedString(@"Jobs", @"Title for flash jobs in toolbar")];
}

- (NSArray *)swipeViewControllers
{
    return @[
             [[BDJNewsListViewController alloc] initWithFeed:BDJNewsFeedFlash],
             [[BDJNewsListViewController alloc] initWithFeed:BDJNewsFeedSpecials],
             [[BDJNewsListViewController alloc] initWithFeed:BDJNewsFeedJobs]
             ];
}

@end
