//
//  BDJDirectorioWorker.m
//  iBadajoz
//
//  Created by David Cordero on 26/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "BDJDirectorioWorker.h"

#import "BDJDirectorio.h"
#import "Configuration.h"
#import "ApiClient.h"
#import "DLog.h"
#import "Storage.h"

@implementation BDJDirectorioWorker

- (NSURLSessionDataTask *)fetchAllContactsWithSuccessBlock:(WorkerSuccessBlock)success errorBlock:(WorkerFailureBlock)failure
{
    BDJDirectorio *directorio = [Storage fetchDataOfType:[BDJDirectorio class] fromStorage:STORAGE_DIRECTORIO];
    if (directorio) {
        success (directorio, YES);
    }
    
    return [super runTaskNow:^NSURLSessionDataTask *{
        NSURLSessionDataTask * task = [[ApiClient sharedInstance] getPath:DIRECTORIO_URL parameters:nil resultBlock:^(NSURLResponse *response, id responseObject, NSError *error) {
            
            if (error) {
                DLog(@"%@", error);
                if (failure) {
                    failure(error);
                }
                return;
            }
            
            NSError *parseError;
            BDJDirectorio *directorio = [[BDJDirectorio alloc] initWithData:responseObject
                                                                      error:&parseError];
            
            if (directorio) {
                [Storage saveData:directorio inStorage:STORAGE_DIRECTORIO];

                if (success) {
                    success (directorio, NO);
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
