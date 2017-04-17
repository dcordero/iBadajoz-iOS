//
//  BDJNewsListViewCell.m
//  Badajoz
//
//  Created by David Cordero on 11/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJNewsListViewCell.h"

@implementation BDJNewsListViewCell

- (id)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJNewsListViewCell class]) owner:nil options:nil] lastObject];
}

@end
