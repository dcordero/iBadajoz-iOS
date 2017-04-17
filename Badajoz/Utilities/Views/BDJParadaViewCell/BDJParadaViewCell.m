//
//  BDJParadaViewCell.m
//  Badajoz
//
//  Created by David Cordero on 24/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJParadaViewCell.h"
#import "UIColor+BadajozColors.h"

@interface BDJParadaViewCell ()

@property (strong, nonatomic) UIColor *iconColor;

@end

@implementation BDJParadaViewCell

- (id)init
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BDJParadaViewCell class]) owner:nil options:nil] lastObject];
}

- (void)setIconColor:(UIColor *)color
{
    _iconColor = color;
	[self setupViewCell];
}

#pragma mark - Private

- (void)setupViewCell
{
    self.paradaIcon.layer.cornerRadius = 10;
    self.paradaIcon.backgroundColor = self.iconColor;
    self.paradaIcon.layer.borderColor = [[UIColor badajozTintColor] CGColor];
    self.paradaIcon.layer.borderWidth = 0.5f;
    
    self.previousConnection.backgroundColor = self.iconColor;
    self.nextConnection.backgroundColor = self.iconColor;
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
