//
//  BDJTransporteWorker.h
//  iBadajoz
//
//  Created by David Cordero on 29/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseWorker.h"
#import "BDJParada.h"
#import "BDJLinea.h"

@interface BDJTransporteWorker : BaseWorker

- (NSURLSessionDataTask *)fetchAllLinesWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure;
- (void)fetchStopInfoForParada:(BDJParada *)parada andLine:(BDJLinea *)linea withSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure;
- (NSURLSessionDataTask *)fetchBiBaMapWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure;
- (NSURLSessionDataTask *)fetchHandicaptedMapWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure;

@end
