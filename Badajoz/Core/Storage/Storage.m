//
//  Storage.m
//  iBadajoz
//
//  Created by David Cordero on 9/11/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "Storage.h"
#import "DLog.h"
#import <TMCache/TMCache.h>


@implementation Storage

#pragma mark - Public

+ (void)saveData:(id<NSCoding>)data inStorage:(NSString *)storage
{    
    // Synchronous to memory
    [[[TMCache sharedCache] memoryCache] setObject:data forKey:storage];

    // Asynchronous to disk
    [[[TMCache sharedCache] diskCache] setObject:data forKey:storage block:^(TMDiskCache *cache, NSString *key, id<NSCoding> object, NSURL *fileURL) { /* Do nothing */ }];
}

+ (BOOL)containsStorage:(NSString *)storage
{
    id data = [[TMCache sharedCache] objectForKey:storage];
    return (data == nil) ? NO : YES;
}

+ (id)fetchDataOfType:(Class)dataClassType fromStorage:(NSString *)storage
{
    id data = [[TMCache sharedCache] objectForKey:storage];
    
    if ([data isKindOfClass:dataClassType]) {
        return data;
    }
    else if (data) {
        [[TMCache sharedCache] removeObjectForKey:storage];
        DLog(@"Error fetching data from Storage, mismatch data type. Wanted %@, found %@.", dataClassType, [data class]);
    }
    
    return nil;
}

+ (void)deleteStorage:(NSString *)storage
{
    [[TMCache sharedCache] removeObjectForKey:storage];
}

+ (void)usingStorage:(NSString *)storage getDataOfType:(Class)dataClassType andDoSomething:(id<NSCoding>(^)(id<NSCoding> data))block
{
    id data = [Storage fetchDataOfType:dataClassType fromStorage:storage];
    id modified_data;

    if (data) {
        modified_data = block(data);
    }
    
    if (modified_data) {
        [Storage saveData:modified_data inStorage:storage];
    }
}

@end
