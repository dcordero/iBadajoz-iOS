//
//  UIColor+BadajozColors.m
//  Badajoz
//
//  Created by David Cordero on 06/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "UIColor+BadajozColors.h"

@implementation UIColor (BadajozColors)


+ (UIColor *)badajozBaseColor
{
    return [self colorWithRed:215.0f/255.0f green:226.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
}

+ (UIColor *)badajozTintColor
{
    return [self colorWithRed:21.0f/255.0f green:110.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
}

@end
