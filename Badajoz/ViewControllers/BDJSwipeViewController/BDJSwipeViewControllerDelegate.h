//
//  BDJSwipeViewControllerDelegate.h
//  Badajoz
//
//  Created by David Cordero on 09/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDJSwipeViewController;

@protocol BDJSwipeViewControllerDelegate <NSObject>

@optional
- (void)swipeViewController:(BDJSwipeViewController *)swipeViewController didChangeSelectionToIndex:(NSUInteger)index;

@end
