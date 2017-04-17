//
//  BDJSegmentedSwipeViewController.m
//  Badajoz
//
//  Created by David Cordero on 06/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJSegmentedSwipeViewController.h"
#import "NSLayoutConstraint+Helper.h"
#import "BDJBackgroundView.h"
#import "BDJNavigationController.h"

static CGFloat const kToolbarHeight = 32.0f;

@interface BDJSegmentedSwipeViewController ()

@end

@implementation BDJSegmentedSwipeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTitle];
    [self showNewsToolbarViewController];
    [self showNewsSwipeViewController];
    [self showNewsBackgroundView];
    [self configureNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BDJSegmentedToolbarViewController *)newsToolbarViewController
{
    if (!_newsToolbarViewController) {
        
        NSArray *toolbarElements = [self toolbarElements];
        _newsToolbarViewController = [[BDJSegmentedToolbarViewController alloc] initWithElements:toolbarElements];
        _newsToolbarViewController.delegate = self;
    }
    return _newsToolbarViewController;
}

- (BDJSwipeViewController *)newsSwipeViewController
{
    if (!_newsSwipeViewController) {
        _newsSwipeViewController = [[BDJSwipeViewController alloc] init];
        _newsSwipeViewController.delegate = self;
        _newsSwipeViewController.contentViewControllers = [self swipeViewControllers];
    }
    return _newsSwipeViewController;
}

#pragma mark - Private

- (NSArray *)toolbarElements
{
    return @[];
}

- (NSArray *)swipeViewControllers
{
    return @[];
}

- (void)configureNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Menu icon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:(BDJNavigationController *)self.navigationController
                                                                            action:@selector(showMenu)];
}

- (void)setupTitle
{
}

- (void)showNewsToolbarViewController
{
    [self setupViewControllerAsAChild:self.newsToolbarViewController];
    [self addConstraintsForToolbarView];
}

- (void)showNewsSwipeViewController
{
    [self setupViewControllerAsAChild:self.newsSwipeViewController];
    [self addConstraintsForNewsSwipeViewController];
}

- (void)showNewsBackgroundView
{
    BDJBackgroundView *backgroundView = [[BDJBackgroundView alloc] init];
    backgroundView.frame = self.view.bounds;
    
    [self.view insertSubview:backgroundView atIndex:0];
    
}

- (void)setupViewControllerAsAChild:(UIViewController *)viewController
{
    [self addChildViewController:viewController];
    
    viewController.view.frame = self.view.bounds;
    
    [self.view insertSubview:viewController.view atIndex:0];
    [viewController didMoveToParentViewController:self];
}

- (void)addConstraintsForToolbarView
{
    self.newsToolbarViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.newsToolbarViewController.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.newsToolbarViewController.view
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:0
                                                         multiplier:1.0f
                                                           constant:kToolbarHeight]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toolbar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"toolbar" : self.newsToolbarViewController.view}]];
}

- (void)addConstraintsForNewsSwipeViewController
{
    self.newsSwipeViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.newsSwipeViewController.view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.newsToolbarViewController.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.newsSwipeViewController.view
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bottomLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0f
                                                           constant:0.0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[swipeviewcontroller]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"swipeviewcontroller" : self.newsSwipeViewController.view}]];
}

#pragma mark - BDJSwipeViewControllerDelegate

- (void)swipeViewController:(BDJSwipeViewController *)swipeViewController didChangeSelectionToIndex:(NSUInteger)index
{
    [self.newsToolbarViewController.sections setSelectedSegmentIndex:index];
}

#pragma mark - BDJNewsToolbarViewControllerDelegate

- (void)toolbarViewController:(BDJSegmentedToolbarViewController *)toolbarViewController didChangeValueToIndex:(NSUInteger)index
{
    [self.newsSwipeViewController setViewControllerAtIndex:index];
}

@end
