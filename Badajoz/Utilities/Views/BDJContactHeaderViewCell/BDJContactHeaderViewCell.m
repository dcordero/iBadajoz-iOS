//
//  BDJContactHeaderViewCell.m
//  Badajoz
//
//  Created by David Cordero on 29/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJContactHeaderViewCell.h"

@implementation BDJContactHeaderViewCell


- (id)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJContactHeaderViewCell class]) owner:nil options:nil] lastObject];
}

@end
