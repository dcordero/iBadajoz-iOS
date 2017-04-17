//
//  BDJDirectorio.m
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJDirectorio.h"
#import <GDataXMLNode.h>
#import "Configuration.h"
#import "BDJContactCategory.h"
#import "NSObject+NSCoding.h"

@implementation BDJDirectorio

- initWithData:(id)data error:(NSError **)error
{
    self = [super init];
    if (self)
    {
        GDataXMLDocument *xmlDocument = [[GDataXMLDocument alloc] initWithData:data
                                                                      encoding:FEED_ENCODING
                                                                         error:error];
        
        [self parse:xmlDocument.rootElement error:error];
    }
    return self;
}

# pragma mark - Private

- (void)parse:(GDataXMLElement *)data error:(NSError **)error
{
    NSMutableArray *parsedContactCategories = [[NSMutableArray alloc] init];
    for (GDataXMLElement *category in [data elementsForName:@"categoria"]) {
        BDJContactCategory *contactCategory = [[BDJContactCategory alloc] initWithData:category error:error];
        if (contactCategory) {
            [parsedContactCategories addObject:contactCategory];
        }
    }
    self.contactCategories = [NSArray arrayWithArray:parsedContactCategories];
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
