//
//  BDJSegmentedSwipeViewController.h
//  Badajoz
//
//  Created by David Cordero on 06/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDJSegmentedToolbarViewController.h"
#import "BDJNewsListViewController.h"
#import "BDJSwipeViewController.h"
#import "BDJSwipeViewControllerDelegate.h"
#import "BDJNewsToolbarViewControllerDelegate.h"

@interface BDJSegmentedSwipeViewController : UIViewController <BDJSwipeViewControllerDelegate, BDJSegmentedToolbarViewControllerDelegate>

@property (strong, nonatomic) BDJSegmentedToolbarViewController *newsToolbarViewController;
@property (strong, nonatomic) BDJSwipeViewController *newsSwipeViewController;

@end
