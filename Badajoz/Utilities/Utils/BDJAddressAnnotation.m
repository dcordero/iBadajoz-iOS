//
//  BDJAddressAnnotation.m
//  Badajoz
//
//  Created by David Cordero on 28/03/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJAddressAnnotation.h"

@interface BDJAddressAnnotation ()
@property (assign, nonatomic)CLLocationCoordinate2D coordinate;
@end

@implementation BDJAddressAnnotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    if (self) {
        _coordinate=coordinate;
    }
    return self;
}

- (NSString *)subtitle{
    return nil;
}

- (NSString *)title{
    return nil;
}

@end
