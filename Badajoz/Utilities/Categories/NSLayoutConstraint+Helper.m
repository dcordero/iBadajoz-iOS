//
//  NSLayoutConstraint+Helper.m
//  Badajoz
//
//  Created by David Cordero on 08/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "NSLayoutConstraint+Helper.h"

@implementation NSLayoutConstraint (Helper)

+ (NSArray *)constraintsForItem:(UIView*)subview toFitParent:(UIView *)parent
{
    return @[
             [self constraintEqualityOn:NSLayoutAttributeTop forSubview:subview toItem:parent],
             [self constraintEqualityOn:NSLayoutAttributeLeading forSubview:subview toItem:parent],
             [self constraintEqualityOn:NSLayoutAttributeBottom forSubview:subview toItem:parent],
             [self constraintEqualityOn:NSLayoutAttributeTrailing forSubview:subview toItem:parent]
             ];
}

+ (NSLayoutConstraint *)constraintEqualityOn:(NSLayoutAttribute)attribute forSubview:(UIView*)subview toItem:(UIView *)parentView
{
    return [NSLayoutConstraint constraintWithItem:subview
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:parentView
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:0.0];
}


@end
