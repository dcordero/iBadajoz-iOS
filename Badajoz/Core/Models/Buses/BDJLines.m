//
//  BDJLines.m
//  iBadajoz
//
//  Created by David Cordero on 29/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJLines.h"

#import <GDataXMLNode.h>
#import "Configuration.h"
#import "BDJLinea.h"

#import <Mantle/MTLValueTransformer.h>
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation BDJLines

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"lineas"    : @"lineas",
             };
}

+ (NSValueTransformer *)lineasJSONTransformer
{
    
    return [MTLValueTransformer transformerWithBlock:^(NSArray *contents) {
        NSMutableArray *lineas = [[NSMutableArray alloc] init];
        for (NSDictionary *content in contents) {
            BDJLinea *currentLinea = [MTLJSONAdapter modelOfClass:[BDJLinea class] fromJSONDictionary:content error:nil];
            if (currentLinea) {
                [lineas addObject:currentLinea];
            }
        }
        return [NSArray arrayWithArray:lineas];
    }];
}

@end
