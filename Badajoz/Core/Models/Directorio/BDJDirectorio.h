//
//  BDJDirectorio.h
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJDirectorio : NSObject <NSCoding>

@property (strong,nonatomic) NSArray *contactCategories;

- initWithData:(id)data error:(NSError **)error;

@end
