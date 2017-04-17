//
//  BDJSwipeViewController.m
//  Badajoz
//
//  Created by David Cordero on 09/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJSwipeViewController.h"
#import "BDJNewsListViewController.h"
#import "UIColor+BadajozColors.h"

@implementation BDJSwipeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    BDJNewsListViewController *initialViewController = [self.contentViewControllers firstObject];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

#pragma mark - Public

- (void)setViewControllerAtIndex:(NSInteger)index
{
    NSUInteger currentIndex = [self.contentViewControllers indexOfObject:[self.pageController.viewControllers lastObject]];
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if (currentIndex > index) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    UIViewController *viewController = [self.contentViewControllers objectAtIndex:index];
    
    // Workaround for UIPageViewController http://www.apeth.com/iOSBook/ch19.html#_page_view_controller
    __weak UIPageViewController* pvcw = self.pageController;
    [self.pageController setViewControllers:@[viewController]
                  direction:direction
                   animated:YES completion:^(BOOL finished) {
                       UIPageViewController* pvcs = pvcw;
                       if (!pvcs) return;
                       dispatch_async(dispatch_get_main_queue(), ^{
                           [pvcs setViewControllers:@[viewController]
                                          direction:direction
                                           animated:NO completion:nil];
                       });
                   }];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    
    if (index == 0) {
        return nil;
    }
    
    return self.contentViewControllers[index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    
    if (index >= self.contentViewControllers.count - 1) {
        return nil;
    }
    
    return self.contentViewControllers[index + 1];
}

- (BDJNewsListViewController *)viewControllerAtIndex {
    
    BDJNewsListViewController *childViewController = [[BDJNewsListViewController alloc] init];
    return childViewController;
    
}


#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed;
{
    if (!completed)
    {
        return;
    }
    
    NSUInteger index = [self.contentViewControllers indexOfObject:[self.pageController.viewControllers lastObject]];
    if([self.delegate respondsToSelector:@selector(swipeViewController:didChangeSelectionToIndex:)]) {
        [self.delegate swipeViewController:self didChangeSelectionToIndex:index];
    }
}

@end
