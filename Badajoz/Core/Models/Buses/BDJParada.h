//
//  BDJParada.h
//  iBadajoz
//
//  Created by David Cordero on 29/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MTLModel.h>
#import <MTLJSONAdapter.h>

@interface BDJParada : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *idp;
@property (strong, nonatomic) NSString *ido;
@property (strong, nonatomic) NSString *label;


@end
