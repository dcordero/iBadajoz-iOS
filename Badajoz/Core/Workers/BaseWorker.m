//
//  BaseWorker.m
//
//  Created by David Cordero on 13/11/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BaseWorker.h"

#import <MTLJSONAdapter.h>

@implementation BaseWorker

#pragma mark - Public

- (NSURLSessionDataTask *)runTaskNow:(NSURLSessionDataTask * (^)())invocation 
{
    NSURLSessionDataTask *task = invocation();
    [task resume];
    return task;
}

- (NSURLSessionDataTask *)runTaskCancelPrevious:(NSURLSessionDataTask * (^)())invocation 
{
    [self.lastDataTask cancel];

    NSURLSessionDataTask *task = invocation();
    self.lastDataTask = task;
    [self.lastDataTask resume];
    
    return self.lastDataTask;
}

- (NSURLSessionDataTask *)runTaskWithQueue:(NSURLSessionDataTask * (^)())invocation 
{
    // WARNING: Not implemented
    return nil;
}

#pragma mark - Mantle parsing

+ (id)parseData:(id)data withClass:(Class)class error:(NSError **)parseError
{
    id parsedData = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:data error:parseError];
    
    // Workaround for Mantle bug, where both data and error are empty.
    if (!parsedData && !*parseError) {
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: @"Unknown Mantle parsing error",
                                   NSLocalizedFailureReasonErrorKey: @"MantleErrorUnknown"
                                   };
        
        *parseError = [[NSError alloc] initWithDomain:MTLJSONAdapterErrorDomain
                                                 code: 1
                                             userInfo:userInfo];
    }
    
    return parsedData;
}

+ (void)parseDataAsync:(id)data withClass:(Class)class successParsingBlock:(ParserSuccessBlock)parserSuccessBlock errorParsingBlock:(ParserFailureBlock)parserFailureBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *parseError = nil;
        id parsedData = [BaseWorker parseData:data withClass:class error:&parseError];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (parseError) {
                if (parserFailureBlock) {
                    parserFailureBlock (parseError);
                }
            }
            else if (parserSuccessBlock) {
                parserSuccessBlock (parsedData);
            }
            
        });
    });
}


@end
