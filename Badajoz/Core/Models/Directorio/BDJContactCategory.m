//
//  BDJContactCategory.m
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJContactCategory.h"

#import <GDataXMLNode.h>
#import "BDJContact.h"
#import "NSObject+NSCoding.h"

@implementation BDJContactCategory

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
    self.label = [[data attributeForName:@"nombrecategoria"] stringValue];
    self.code = [[data attributeForName:@"idcategoria"] stringValue];
    
    NSMutableArray *parsedContacts = [[NSMutableArray alloc] init];
    for (GDataXMLElement *currentContact in [data elementsForName:@"contacto"] ) {
        BDJContact *contact = [[BDJContact alloc] initWithData:currentContact error:error];
        if (contact) {
            [parsedContacts addObject:contact];
        }
    }
    self.contacts = [NSArray arrayWithArray:parsedContacts];
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
