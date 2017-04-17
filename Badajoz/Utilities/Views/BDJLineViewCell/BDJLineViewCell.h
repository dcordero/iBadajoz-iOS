//
//  BDJLineViewCell.h
//  Badajoz
//
//  Created by David Cordero on 23/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJLineViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIView *lineIcon;
@property (weak, nonatomic) IBOutlet UILabel *lineDescription;

- (void)setIconColor:(UIColor *)color;

@end
