//
//  UIImage+Color.h
//  Badajoz
//
//  Created by David Cordero on 07/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;

@end
