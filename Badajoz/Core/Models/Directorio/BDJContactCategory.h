//
//  BDJContactCategory.h
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJContactCategory : NSObject <NSCoding>

@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *code;
@property (strong,nonatomic) NSArray *contacts;

- initWithData:(id)data error:(NSError **)error;

@end
