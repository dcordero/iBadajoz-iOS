//
//  BDJFeedWorker.m
//  iBadajoz
//
//  Created by David Cordero on 18/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJFeedWorker.h"

#import "BDJFeedChannel.h"
#import "ApiClient.h"
#import "Storage.h"
#import "Configuration.h"
#import "DLog.h"

@implementation BDJFeedWorker

- (NSURLSessionDataTask *)fetchFlashNewsWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{
    BDJFeedChannel *feedChannel = [Storage fetchDataOfType:[BDJFeedChannel class] fromStorage:STORAGE_FLASH];
    if (feedChannel) {
        success (feedChannel, YES);
    }
    
    return [self fetchRSSFromURL:RSS_FLASH toStorage:STORAGE_FLASH withSuccessBlock:success errorBlock:failure];
}

- (NSURLSessionDataTask *)fetchSpecialsNewsWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{
    BDJFeedChannel *feedChannel = [Storage fetchDataOfType:[BDJFeedChannel class] fromStorage:STORAGE_SPECIALS];
    if (feedChannel) {
        success (feedChannel, YES);
    }
    
    return [self fetchRSSFromURL:RSS_SPECIALS toStorage:STORAGE_SPECIALS withSuccessBlock:success errorBlock:failure];
}

- (NSURLSessionDataTask *)fetchJobsNewsWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{
    BDJFeedChannel *feedChannel = [Storage fetchDataOfType:[BDJFeedChannel class] fromStorage:STORAGE_JOBS];
    if (feedChannel) {
        success (feedChannel, YES);
    }
    
    return [self fetchRSSFromURL:RSS_JOBS toStorage:STORAGE_JOBS withSuccessBlock:success errorBlock:failure];
}

#pragma mark - Private

- (NSURLSessionDataTask *)fetchRSSFromURL:(NSString *)url toStorage:(NSString *)storage withSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{
    return [super runTaskNow:^NSURLSessionDataTask *{
        NSURLSessionDataTask * task = [[ApiClient sharedInstance] getPath:url parameters:nil resultBlock:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            if (error) {
                DLog(@"%@", error);
                if (failure) {
                    failure(error);
                }
                return;
            }
            
            NSError *parseError;
            BDJFeedChannel *rssFeed = [[BDJFeedChannel alloc] initWithData:responseObject
                                                                     error:&parseError feedUrl:url];
            
            if (rssFeed.rssItems) {
                [Storage saveData:rssFeed inStorage:storage];
                
                if (success) {
                    success (rssFeed, NO);
                }
            }
            else {
                DLog(@"%@", parseError);
                if (failure) {
                    failure (parseError);
                }
            }
        }];
        
        return task;
    }];
}



@end
