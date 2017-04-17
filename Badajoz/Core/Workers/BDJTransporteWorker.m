//
//  BDJTransporteWorker.m
//  iBadajoz
//
//  Created by David Cordero on 29/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJTransporteWorker.h"

#import "Configuration.h"
#import "ApiClient.h"
#import "BDJLines.h"
#import "BDJStopInfo.h"
#import "DLog.h"
#import "Storage.h"
#import "MTLModel+NSCoding.h"

@implementation BDJTransporteWorker

- (NSURLSessionDataTask *)fetchAllLinesWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{
    BDJLines *lines = [Storage fetchDataOfType:[BDJLines class] fromStorage:STORAGE_BUSES];
    if (lines) {
        success (lines, YES);
    }
    
    return [super runTaskNow:^NSURLSessionDataTask *{
        NSURLSessionDataTask * task = [[ApiClient sharedInstance] getPath:LINES_URL parameters:nil resultBlock:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            if (error) {
                DLog(@"%@", error);
                if (failure) {
                    failure(error);
                }
                return;
            }
            
            [BaseWorker parseDataAsync:responseObject withClass:[BDJLines class]
                   successParsingBlock:^(id model) {
                       BDJLines *parsedLines = model;
                       if (parsedLines) {
                           [Storage saveData:parsedLines inStorage:STORAGE_BUSES];
                           
                           if (success) {
                               success(parsedLines, NO);
                           }
                       }
                   } errorParsingBlock:^(NSError *error) {
                       DLog(@"%@", error);
                       if (failure) {
                           failure(error);
                       }
                   }
             ];
        }];
        
        return task;
    }];
}

- (void)fetchStopInfoForParada:(BDJParada *)parada andLine:(BDJLinea *)linea withSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{
    
    [super runTaskNow:^NSURLSessionDataTask *{
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"idl": linea.code,
                                                                     @"idp": parada.idp,
                                                                     @"ido": parada.ido }
                                                           options:0
                                                             error:nil];

        
        NSURLSessionDataTask * task = [[ApiClient sharedInstance]
                                       postPath:PARADA_URL
                                       data:jsonData
                                       headers: @{ @"x-api-key": AWS_API_KEY}
                                       resultBlock:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            if (error) {
                if (failure) {
                    failure(error);
                }
                return;
            }
            
            [BaseWorker parseDataAsync:responseObject withClass:[BDJStopInfo class]
                   successParsingBlock:^(id model) {
                       BDJLines *parsedStopInfo = model;
                       if (parsedStopInfo) {
                           if (success) {
                               success(parsedStopInfo, NO);
                           }
                       }
                   } errorParsingBlock:^(NSError *error) {
                       DLog(@"%@", error);
                       if (failure) {
                           failure(error);
                       }
                   }
             ];
        }];
        
        return task;
    }];
}

- (NSURLSessionDataTask *)fetchBiBaMapWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{

    return [super runTaskNow:^NSURLSessionDataTask *{
        NSURLSessionDataTask * task = [[ApiClient sharedInstance] getPath:BIBA_URL parameters:nil resultBlock:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            if (error) {
                DLog(@"%@", error);
                if (failure) {
                    failure(error);
                }
                return;
            }
            
            [Storage saveData:responseObject inStorage:STORAGE_BIBA];
            if (success) {
                success(responseObject, NO);
            }
        }];
        
        return task;
    }];
}

- (NSURLSessionDataTask *)fetchHandicaptedMapWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{

    return [super runTaskNow:^NSURLSessionDataTask *{
        NSURLSessionDataTask * task = [[ApiClient sharedInstance] getPath:HANDICAPTED_URL parameters:nil resultBlock:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            if (error) {
                DLog(@"%@", error);
                if (failure) {
                    failure(error);
                }
                return;
            }
            
            [Storage saveData:responseObject inStorage:STORAGE_HANDICAPTED];
            if (success) {
                success(responseObject, NO);
            }
        }];
        
        return task;
    }];}

@end





