//
//  BDJPieceOfNewsViewController.h
//  Badajoz
//
//  Created by David Cordero on 12/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDJRSSItem.h"

@interface BDJPieceOfNewsViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *bodyWebView;

- (id)initWithRSSItem:(BDJRSSItem *)rssItem;

@end
