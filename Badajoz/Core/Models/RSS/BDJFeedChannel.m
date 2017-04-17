//
//  BDJFeedChannel.m
//  iBadajoz
//
//  Created by David Cordero on 18/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJFeedChannel.h"

#import <GDataXMLNode.h>
#import "BDJRSSItem.h"
#import "Configuration.h"
#import "NSObject+NSCoding.h"

@implementation BDJFeedChannel

- initWithData:(id)data error:(NSError **)error feedUrl:(NSString *)feedUrl;
{
    self = [super init];
    if (self) {
        GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithData:data
                                                                      encoding:FEED_ENCODING
                                                                         error:error];
        
        NSArray *channels = [xmlDocument.rootElement elementsForName:@"channel"];
        for (GDataXMLElement *channelMember in channels) {
            [self parse:channelMember error:error];
        }
        _feedUrl = feedUrl;
    }
    return self;
}

# pragma mark - Private

- (void)parse:(GDataXMLElement *)data error:(NSError **)error
{
    // Title
    NSArray *titles = [data elementsForName:@"title"];
    if (titles.count > 0) {
        GDataXMLElement *firstName = (GDataXMLElement *) [titles objectAtIndex:0];
        self.title = firstName.stringValue;
    } else return;
    
    // Items
    NSMutableArray *parsedItems = [[NSMutableArray alloc] init];
    NSArray *items = [data elementsForName:@"item"];
    for (GDataXMLElement *currentItem in items) {
        BDJRSSItem *rssItem = [[BDJRSSItem alloc] initWithData:currentItem
                                                         error:error];
        if (rssItem) {
            [parsedItems addObject:rssItem];
        }
    }
    self.rssItems = parsedItems;
    
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [self autoEncodeWithCoder:coder];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        [self autoDecode:coder];
    }
    return self;
}

@end
