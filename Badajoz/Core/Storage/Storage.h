//
//  Storage.h
//  iBadajoz
//
//  Created by David Cordero on 9/11/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Storage : NSObject

/**
 Returns true if the system contains the indicated storaged
 */
+ (BOOL)containsStorage:(NSString *)storage;

/**
 Save data to memory cache (synchronously) and disk (asynchronously).
 The size of the disk cache is limited to NGDiskCacheLimitInBytes. When it's full, old stuff will be removed.
 */
+ (void)saveData:(id<NSCoding>)data inStorage:(NSString *)storage;

/**
 Load data from memory cache, if found.
 If not found, load from disk cache.
 */
+ (id)fetchDataOfType:(Class)dataClassType fromStorage:(NSString *)storage;

/**
 Delete data from storage.
 */
+ (void)deleteStorage:(NSString *)storage;

/**
 Read from storage, run a block access to that data and finally write the result back to storage.
 After doing stuff with the data you need to return it from the block, in order to save it.
 Return 'nil' from the block to not save anything.
 */
+ (void)usingStorage:(NSString *)storage getDataOfType:(Class)dataClassType andDoSomething:(id<NSCoding>(^)(id<NSCoding> data))block;

@end
