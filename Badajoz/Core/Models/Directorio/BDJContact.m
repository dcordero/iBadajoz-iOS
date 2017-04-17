//
//  BDJContact.m
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJContact.h"

#import <GDataXMLNode.h>
#import "NSObject+NSCoding.h"

@implementation BDJContact

- initWithData:(id)data error:(NSError **)error
{
    self = [super init];
    if (self)
    {
        [self parse:data error:error];
    }
    return self;
}

# pragma mark - Private

- (void)parse:(GDataXMLElement *)data error:(NSError **)error
{
    // Name
    NSArray *names = [data elementsForName:@"nombre"];
    if (names.count > 0) {
        GDataXMLElement *firstName = (GDataXMLElement *) [names objectAtIndex:0];
        self.name = [firstName.stringValue capitalizedString];
    }
    
    // Address
    NSArray *addresses = [data elementsForName:@"direccion"];
    if (addresses.count > 0) {
        GDataXMLElement *firstAddress = (GDataXMLElement *) [addresses objectAtIndex:0];
        self.address = [firstAddress.stringValue capitalizedString];
    }
    
    // Phone 1
    NSArray *phones1 = [data elementsForName:@"telefono1"];
    if (phones1.count > 0) {
        GDataXMLElement *firstPhone1 = (GDataXMLElement *) [phones1 objectAtIndex:0];
        self.phone1 = [firstPhone1.stringValue stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    // Phone 2
    NSArray *phones2 = [data elementsForName:@"telefono2"];
    if (phones2.count > 0) {
        GDataXMLElement *firstPhone2 = (GDataXMLElement *) [phones2 objectAtIndex:0];
        self.phone2 = [firstPhone2.stringValue stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    // Fax
    NSArray *faxes = [data elementsForName:@"fax"];
    if (faxes.count > 0) {
        GDataXMLElement *firstFax = (GDataXMLElement *) [faxes objectAtIndex:0];
        self.fax = firstFax.stringValue;
    }
    
    // Email
    NSArray *emails = [data elementsForName:@"email"];
    if (emails.count > 0) {
        GDataXMLElement *firstEmail = (GDataXMLElement *) [emails objectAtIndex:0];
        self.email = firstEmail.stringValue;
    }
    
    // Web
    NSArray *webs = [data elementsForName:@"web"];
    if (webs.count > 0) {
        GDataXMLElement *firstWeb = (GDataXMLElement *) [webs objectAtIndex:0];
        self.web = firstWeb.stringValue;
    }
    
    // Longitude
    NSArray *longitudes = [data elementsForName:@"longitud"];
    if (longitudes.count > 0) {
        GDataXMLElement *firstLongitude = (GDataXMLElement *) [longitudes objectAtIndex:0];
        self.longitud = [firstLongitude.stringValue floatValue];
    }
    
    // Latitude
    NSArray *latitudes = [data elementsForName:@"latitud"];
    if (latitudes.count > 0) {
        GDataXMLElement *firstLatitude = (GDataXMLElement *) [latitudes objectAtIndex:0];
        self.latitud = [firstLatitude.stringValue floatValue];
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
