//
//  BDJNavigationController.m
//  iBadajoz
//
//  Created by David Cordero on 23/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJNavigationController.h"
#import "BDJSideMenuViewController.h"

@interface BDJNavigationController ()

@property (strong, readwrite, nonatomic) BDJSideMenuViewController *menuViewController;

@end

@implementation BDJNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}


@end
