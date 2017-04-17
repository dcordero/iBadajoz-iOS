//
//  TMDiskCache+Helper.h
//  Badajoz
//
//  Created by David Cordero on 23/05/14.
//  Copyright (c) 2014 David Cordero. All rights reserved.
//

#import "TMDiskCache.h"

@interface TMDiskCache (Helper)

- (NSURL *)encodedFileURLForKey:(NSString *)key;

@end
