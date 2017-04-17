//
//  BDJStopInfo.m
//  Badajoz
//
//  Created by David Cordero on 29/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "BDJStopInfo.h"

#import <Mantle/MTLValueTransformer.h>
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@implementation BDJStopInfo

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"name"        : @"name",
             @"nextStop"    : @"next_time",
             @"connections" : @"connections"
             };
}

+ (NSValueTransformer *)connectionsJSONTransformer
{
    
    return [MTLValueTransformer transformerWithBlock:^(NSArray *contents) {
        NSMutableArray *connections = [[NSMutableArray alloc] init];
        for (NSDictionary *content in contents) {
            BDJStopInfo *currentStop = [MTLJSONAdapter modelOfClass:[BDJStopInfo class] fromJSONDictionary:content error:nil];
            if (currentStop) {
                [connections addObject:currentStop];
            }
        }
        return [NSArray arrayWithArray:connections];
    }];
}
            
@end
