//
//  NSLayoutConstraint+Helper.h
//  Badajoz
//
//  Created by David Cordero on 08/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Helper)

+ (NSArray *)constraintsForItem:(UIView*)subview toFitParent:(UIView *)parent;
+ (NSLayoutConstraint *)constraintEqualityOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview toItem:(UIView *)parentView;

@end

