//
//  BDJContact.h
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJContact : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *phone1;
@property (strong, nonatomic) NSString *phone2;
@property (strong, nonatomic) NSString *fax;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *web;
@property (assign, nonatomic) double latitud;
@property (assign, nonatomic) double longitud;

- initWithData:(id)data error:(NSError **)error;

@end
