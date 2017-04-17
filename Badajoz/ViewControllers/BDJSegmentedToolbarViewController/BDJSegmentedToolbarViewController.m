//
//  BDJSegmentedToolbarViewController.m
//  Badajoz
//
//  Created by David Cordero on 07/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJSegmentedToolbarViewController.h"
#import "UIColor+BadajozColors.h"

@interface BDJSegmentedToolbarViewController ()

@property (nonatomic, strong)NSArray *elements;

@end

@implementation BDJSegmentedToolbarViewController

- (id)initWithElements:(NSArray *)elements {
    self = [super init];
    if (self) {
        _elements = elements;
    }
    return self;
}

#pragma mark - UIViewController
- (void)loadView
{
    self.sections = [[UISegmentedControl alloc] init];
    self.view = self.sections;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLayout];
    [self setupButtons];
    [self addConstraintsForSegmentedControl];
}

#pragma mark - Private

- (void)addConstraintsForSegmentedControl
{
    self.sections.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.sections
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.sections
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.sections addConstraint:[NSLayoutConstraint constraintWithItem:self.sections
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:250.0]];

    
    [self.sections addConstraint:[NSLayoutConstraint constraintWithItem:self.sections
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:27.0]];
}

- (void)setupLayout{
    [self.view setBackgroundColor:[UIColor badajozBaseColor]];
}

- (void)setupButtons
{
    self.sections = [[UISegmentedControl alloc] initWithItems:self.elements];
    self.sections.frame = CGRectMake(35, 0, 250, 27);
    self.sections.selectedSegmentIndex = 0;
    
    [self.sections addTarget:self
                      action:@selector(toolbarValueChanged:)
            forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.sections];
}

#pragma mark - Private

- (void)toolbarValueChanged:(id)sender
{
    if([self.delegate respondsToSelector:@selector(toolbarViewController:didChangeValueToIndex:)]) {
        [self.delegate toolbarViewController:self didChangeValueToIndex:[(UISegmentedControl *)sender selectedSegmentIndex]];
    }
}

@end
