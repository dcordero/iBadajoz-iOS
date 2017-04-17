//
//  BDJDirectorioWorker.h
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseWorker.h"

@interface BDJDirectorioWorker : BaseWorker <NSXMLParserDelegate>

- (NSURLSessionDataTask *)fetchAllContactsWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure;

@end
