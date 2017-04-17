//
//  BDJParada.m
//  iBadajoz
//
//  Created by David Cordero on 29/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJParada.h"

#import <Mantle/MTLValueTransformer.h>
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation BDJParada

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"idp"    : @"idp",
             @"ido"    : @"ido",
             @"label"  : @"label",
             };
}

+ (NSValueTransformer *)labelJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithBlock:^(NSString *str) {
        if ([str isEqualToString:@""]) {
            return NSLocalizedString(@"No info", @"Label for stops without a given name");
        }
        return str;
    }];
}

@end
