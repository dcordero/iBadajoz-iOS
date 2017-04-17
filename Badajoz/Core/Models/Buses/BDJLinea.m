//
//  BDJLinea.m
//  iBadajoz
//
//  Created by David Cordero on 29/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJLinea.h"

#import <GDataXMLNode.h>
#import "BDJParada.h"

#import <Mantle/MTLValueTransformer.h>
#import <Mantle/NSDictionary+MTLManipulationAdditions.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@interface BDJLinea ()

@property (strong, nonatomic) NSArray *allStops;

@end

@implementation BDJLinea

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"code"            : @"code",
             @"label"           : @"label",
             @"color"           : @"color",
             @"paradasIda"      : @"paradas.ida",
             @"paradasVuelta"   : @"paradas.vuelta"
             };
}

+ (NSValueTransformer *)paradasIdaJSONTransformer
{
    return [self transformerForParadas];
}

+ (NSValueTransformer *)paradasVueltaJSONTransformer
{
    return [self transformerForParadas];
}

#pragma mark - Private

+ (NSValueTransformer *)transformerForParadas
{
    return [MTLValueTransformer transformerWithBlock:^(NSArray *contents) {
        NSMutableArray *paradas = [[NSMutableArray alloc] init];
        for (NSDictionary *content in contents) {
            BDJParada *currentParada = [MTLJSONAdapter modelOfClass:[BDJParada class] fromJSONDictionary:content error:nil];
            if (currentParada) {
                [paradas addObject:currentParada];
            }
        }
        return [NSArray arrayWithArray:paradas];
    }];
}

#pragma mark - Public

- (NSArray *)allStops
{
    if (!_allStops) {
        NSMutableArray *stops = [[NSMutableArray alloc] init];
        [stops addObjectsFromArray:self.paradasIda];
        [stops addObjectsFromArray:self.paradasVuelta];
        
        _allStops = stops;
    }
    return _allStops;
}

- (NSString *)labelDescriptor
{
    NSString *firstStop = [[self.paradasIda firstObject] label];
    NSString *lastStop = [[self.paradasIda lastObject] label];
    
    return [NSString stringWithFormat:@"%@ → %@", firstStop, lastStop];
}

@end
