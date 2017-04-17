//
//  BDJParadaViewCell.h
//  Badajoz
//
//  Created by David Cordero on 24/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJParadaViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *paradaLabel;
@property (weak, nonatomic) IBOutlet UIView *paradaIcon;
@property (weak, nonatomic) IBOutlet UIView *previousConnection;
@property (weak, nonatomic) IBOutlet UIView *nextConnection;

- (void)setIconColor:(UIColor *)color;

@end
