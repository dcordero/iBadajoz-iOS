//
//  BDJSwipeViewController.h
//  Badajoz
//
//  Created by David Cordero on 09/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDJSwipeViewControllerDelegate.h"

@interface BDJSwipeViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) NSArray *contentViewControllers;
@property (strong, nonatomic) UIPageViewController *pageController;

@property (nonatomic, weak) id<BDJSwipeViewControllerDelegate> delegate;

- (void)setViewControllerAtIndex:(NSInteger)index;

@end
