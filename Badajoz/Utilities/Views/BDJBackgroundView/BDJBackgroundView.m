//
//  BDJNewsBackgroundView.m
//  Badajoz
//
//  Created by David Cordero on 10/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJBackgroundView.h"

@implementation BDJBackgroundView

- (id)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJBackgroundView class]) owner:nil options:nil] lastObject];
}

@end
