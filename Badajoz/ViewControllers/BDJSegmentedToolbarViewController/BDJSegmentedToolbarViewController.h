//
//  BDJSegmentedToolbarViewController.h
//  Badajoz
//
//  Created by David Cordero on 07/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDJNewsToolbarViewControllerDelegate.h"

@interface BDJSegmentedToolbarViewController : UIViewController

@property (strong, nonatomic) UISegmentedControl *sections;
@property (nonatomic, weak) id<BDJSegmentedToolbarViewControllerDelegate> delegate;

- (id)initWithElements:(NSArray *)elements;

@end
