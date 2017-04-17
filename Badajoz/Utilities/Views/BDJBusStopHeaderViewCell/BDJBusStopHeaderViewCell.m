//
//  BDJBusStopHeaderViewCell.m
//  Badajoz
//
//  Created by David Cordero on 02/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJBusStopHeaderViewCell.h"
#import "UIColor+BadajozColors.h"

@implementation BDJBusStopHeaderViewCell

- (id)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJBusStopHeaderViewCell class]) owner:nil options:nil] lastObject];
}

- (void)setBusStopColor:(UIColor *)color
{
    self.busStopIcon.layer.cornerRadius = 15;
    self.busStopIcon.backgroundColor = color;
    self.busStopIcon.layer.borderColor = [[UIColor badajozTintColor] CGColor];
    self.busStopIcon.layer.borderWidth = 0.5f;
}

@end
