//
//  BDJWebViewController.m
//  Badajoz
//
//  Created by David Cordero on 25/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJWebViewController.h"

@interface BDJWebViewController ()
@property (strong, nonatomic) NSURL *url;
@end

@implementation BDJWebViewController

- (id)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = [NSURL URLWithString:url];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
}

@end
