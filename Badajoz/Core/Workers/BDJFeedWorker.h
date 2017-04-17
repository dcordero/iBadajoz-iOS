//
//  BDJFeedWorker.h
//  iBadajoz
//
//  Created by David Cordero on 18/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseWorker.h"

@class BDJFeedChannel;

@interface BDJFeedWorker : BaseWorker <NSXMLParserDelegate>

- (NSURLSessionDataTask *)fetchFlashNewsWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure;
- (NSURLSessionDataTask *)fetchSpecialsNewsWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure;
- (NSURLSessionDataTask *)fetchJobsNewsWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure;

@end
