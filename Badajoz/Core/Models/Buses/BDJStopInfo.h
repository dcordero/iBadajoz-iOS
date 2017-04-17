//
//  BDJStopInfo.h
//  Badajoz
//
//  Created by David Cordero on 29/04/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "MTLModel.h"

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface BDJStopInfo : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nextStop;
@property (strong, nonatomic) NSArray *connections;

@end
