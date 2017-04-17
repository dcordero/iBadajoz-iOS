//
//  BDJRateAppView.m
//  Badajoz
//
//  Created by David Cordero on 20/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJRateAppView.h"

@implementation BDJRateAppView

- (id)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJRateAppView class]) owner:nil options:nil] lastObject];
    [self setupImage];
    return self;
}


- (void)setupImage
{
    self.iconBadajoz.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.iconBadajoz.layer.masksToBounds = YES;
    self.iconBadajoz.layer.cornerRadius = 40.0;
    self.iconBadajoz.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconBadajoz.layer.borderWidth = 3.0f;
    self.iconBadajoz.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.iconBadajoz.layer.shouldRasterize = YES;
    self.iconBadajoz.clipsToBounds = YES;
}

@end
