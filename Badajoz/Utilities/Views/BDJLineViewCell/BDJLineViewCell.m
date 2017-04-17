//
//  BDJLineViewCell.m
//  Badajoz
//
//  Created by David Cordero on 23/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJLineViewCell.h"
#import "UIColor+BadajozColors.h"

@interface BDJLineViewCell ()

@property (strong, nonatomic) UIColor *iconColor;

@end

@implementation BDJLineViewCell

- (id)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJLineViewCell class]) owner:nil options:nil] lastObject];
}

- (void)setIconColor:(UIColor *)color
{
    _iconColor = color;
	[self setupViewCell];
}



#pragma mark - Private

- (void)setupViewCell
{
    self.lineIcon.layer.cornerRadius = 8;
    self.lineIcon.backgroundColor = self.iconColor;
    self.lineIcon.layer.borderColor = [[UIColor badajozTintColor] CGColor];
    self.lineIcon.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self setupViewCell];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [self setupViewCell];
}

@end
