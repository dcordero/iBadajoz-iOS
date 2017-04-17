//
//  BDJBusStopHeaderViewCell.h
//  Badajoz
//
//  Created by David Cordero on 02/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJBusStopHeaderViewCell : UIView

@property (weak, nonatomic) IBOutlet UILabel *busStopName;
@property (weak, nonatomic) IBOutlet UILabel *busStopDescriptor;
@property (weak, nonatomic) IBOutlet UIView *busStopIcon;


- (void)setBusStopColor:(UIColor *)color;

@end
