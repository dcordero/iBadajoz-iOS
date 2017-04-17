//
//  BDJContactsListHeaderViewCell.m
//  Badajoz
//
//  Created by David Cordero on 16/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJContactsListHeaderViewCell.h"

@implementation BDJContactsListHeaderViewCell

- (id)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJContactsListHeaderViewCell class]) owner:nil options:nil] lastObject];
}

@end
