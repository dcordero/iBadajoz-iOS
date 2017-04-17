//
//  BDJSegmentedToolbarViewControllerDelegate.h
//  Badajoz
//
//  Created by David Cordero on 09/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDJSegmentedToolbarViewController;

@protocol BDJSegmentedToolbarViewControllerDelegate <NSObject>

@optional
- (void)toolbarViewController:(BDJSegmentedToolbarViewController *)toolbarViewController didChangeValueToIndex:(NSUInteger)index;

@end
