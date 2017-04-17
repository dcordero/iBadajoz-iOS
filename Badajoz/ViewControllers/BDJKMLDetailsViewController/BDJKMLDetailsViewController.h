//
//  BDJKMLDetailsViewController.h
//  Badajoz
//
//  Created by David Cordero on 17/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMLAbstractGeometry.h"

@interface BDJKMLDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong) KMLAbstractGeometry *geometry;

@end
