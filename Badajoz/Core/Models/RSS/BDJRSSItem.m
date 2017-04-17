//
//  BDJRSSItem.m
//  iBadajoz
//
//  Created by David Cordero on 18/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJRSSItem.h"

#import <GDataXMLNode.h>
#import "NSString+HTML.h"
#import "NSObject+NSCoding.h"

@implementation BDJRSSItem

- initWithData:(id)data error:(NSError **)error
{
    self = [super init];
    if (self) {
        [self parse:data error:error];
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
        self.title = [[firstName.stringValue stringByConvertingHTMLToPlainText] capitalizedString];
    }
    
    // Description
    NSArray *descriptions = [data elementsForName:@"description"];
    if (titles.count > 0) {
        GDataXMLElement *firstDescription = (GDataXMLElement *) [descriptions objectAtIndex:0];
        self.descriptionText = firstDescription.stringValue;
    }
    
    NSArray *links = [data elementsForName:@"link"];
    if (links.count > 0) {
        GDataXMLElement *firstLink = (GDataXMLElement *) [links objectAtIndex:0];
        self.link = firstLink.stringValue;
    }
    
    // Thumbnail
    NSArray *thumbnails = [data elementsForName:@"g:image_link"];
    if (thumbnails.count > 0) {
        GDataXMLElement *firstThumbnail = (GDataXMLElement *) [thumbnails objectAtIndex:0];
        self.thumbnailUrl = [NSURL URLWithString:firstThumbnail.stringValue];
    }
    
    // Date
    NSArray *pubdates = [data elementsForName:@"pubDate"];
    if (pubdates.count > 0) {
        GDataXMLElement *firstDate = (GDataXMLElement *) [pubdates objectAtIndex:0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.date = [dateFormatter dateFromString:firstDate.stringValue];
    }
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
