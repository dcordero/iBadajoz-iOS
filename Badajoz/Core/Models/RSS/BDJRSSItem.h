//
//  BDJRSSItem.h
//  iBadajoz
//
//  Created by David Cordero on 18/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJRSSItem : NSObject <NSCoding>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *descriptionText;
@property (strong, nonatomic) NSURL *thumbnailUrl;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSDate *date;

- initWithData:(id)data error:(NSError **)error;

@end
