//
//  BaseWorker.h
//
//  Created by David Cordero on 13/11/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Prefetch;

typedef void (^WorkerSuccessBlock)(id resultData, BOOL cached);
typedef void (^WorkerFailureBlock)(NSError *error);
typedef void (^WorkerPrefetchBlock)(NSError *error);
typedef void (^ParserSuccessBlock)(id model);
typedef void (^ParserFailureBlock)(NSError *error);

@interface BaseWorker : NSObject

/**
 Used when we need to keep track of the data task which ran last, so that we only run one at a time.
 */
@property (strong, nonatomic) NSURLSessionDataTask *lastDataTask;

/**
 Used when we need to queue up the data tasks and run them one at a time.
 */
@property (strong, nonatomic) NSOperationQueue *dataTaskQueue;

/**
 Run a NSURLSessionDataTask right now, without care of other data tasks.

 @param invocation Block responsible for creating a NSURLSessionDataTask. Will probably get it from ApiClient.
 @return Returns the NSURLSessionDataTask which was created, started.
 */
- (NSURLSessionDataTask *)runTaskNow:(NSURLSessionDataTask * (^)())invocation;

/**
 Run a NSURLSessionDataTask right now, but first make sure that the previous task was not running. Cancel the previous task if neccesary.
 
 @param invocation Block responsible for creating a NSURLSessionDataTask. Will probably get it from ApiClient.
 @return Returns the NSURLSessionDataTask which was created, started.
 */
- (NSURLSessionDataTask *)runTaskCancelPrevious:(NSURLSessionDataTask * (^)())invocation;

/**
 Put a NSURLSessionDataTask in a queue, to be run when it's at the front of the queue.
 
 @warning Not implemented!

 @param invocation Block responsible for creating a NSURLSessionDataTask. Will probably get it from ApiClient.
 @return Returns the NSURLSessionDataTask which was created, possibly started.
 */
- (NSURLSessionDataTask *)runTaskWithQueue:(NSURLSessionDataTask * (^)())invocation;

/**
 Use Mantle to parse JSON data to some specific class.
 
 @param data       JSON data to parse.
 @param class      Class type to parse to. Must be a Mantle object.
 @param parseError Error class to put any errors into.
 
 @return Return the parse data as the specified class.
 */
+ (id)parseData:(id)data withClass:(Class)class error:(NSError **)parseError;


+ (void)parseDataAsync:(id)data withClass:(Class)class successParsingBlock:(ParserSuccessBlock)parserSuccessBlock errorParsingBlock:(ParserFailureBlock)parserFailureBlock;

@end
