//
//  BDJAppDelegate.m
//  Badajoz
//
//  Created by David Cordero on 06/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJAppDelegate.h"

#import "REFrostedViewController.h"
#import "BDJNavigationController.h"
#import "BDJSegmentedSwipeViewController.h"
#import "BDJSideMenuViewController.h"
#import "UIColor+BadajozColors.h"
#import "BDJNewsMainViewController.h"
#import "UIImage+Color.h"
#import "Configuration.h"
#import "Storage.h"
#import "TMDiskCache+Helper.h"
#import <Fabric/Fabric.h>
#import <Answers/Answers.h>

@implementation BDJAppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupWindow];
    [self setUpFabric];
    [self setupDefaultTheme];
    [self setupRootViewController];
    
    return YES;
}

#pragma mark - Private

- (void)setUpFabric
{
    [Fabric with:@[[Answers class]]];
}

- (void)setupDefaultTheme
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor badajozBaseColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor badajozTintColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor badajozTintColor] forKey:NSForegroundColorAttributeName]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageWithColor:[UIColor badajozBaseColor] andSize:CGSizeMake(10, 10)] imageByApplyingAlpha:1] forBarMetrics:UIBarMetricsDefault];
}

- (void)setupWindow
{
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:screenFrame];
    self.window.tintColor = [UIColor badajozTintColor];
    [self.window makeKeyAndVisible];
}

- (void)setupRootViewController
{
    BDJNavigationController *navigationController = [[BDJNavigationController alloc] initWithRootViewController:[[BDJNewsMainViewController alloc] init]];
    BDJSideMenuViewController *sideMenuViewController = [[BDJSideMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:sideMenuViewController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    frostedViewController.panGestureEnabled = NO;
    
    self.window.rootViewController = frostedViewController;
}

@end
