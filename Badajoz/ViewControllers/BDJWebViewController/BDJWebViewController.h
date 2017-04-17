//
//  BDJWebViewController.h
//  Badajoz
//
//  Created by David Cordero on 25/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (id)initWithURL:(NSString *)url;

@end
