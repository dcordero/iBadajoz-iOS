//
//  BDJFeedChannel.h
//  iBadajoz
//
//  Created by David Cordero on 18/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJFeedChannel : NSObject <NSCoding>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *rssItems;
@property (strong, nonatomic) NSString *feedUrl;

- initWithData:(id)data error:(NSError **)error feedUrl:(NSString *)feedUrl;

@end
