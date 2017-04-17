//
//  BDJBusStopCorrespondenciasViewCell.m
//  Badajoz
//
//  Created by David Cordero on 02/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJCustomHeaderGroupViewCell.h"

@implementation BDJCustomHeaderGroupViewCell

- (id)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJCustomHeaderGroupViewCell class]) owner:nil options:nil] lastObject];
}

@end
