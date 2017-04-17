//
//  BDJLinea.h
//  iBadajoz
//
//  Created by David Cordero on 29/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface BDJLinea : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSArray *paradasIda;
@property (strong, nonatomic) NSArray *paradasVuelta;

- (NSArray *)allStops;
- (NSString *)labelDescriptor;

@end
