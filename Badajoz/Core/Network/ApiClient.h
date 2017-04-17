//
//  ApiClient.h
//
//  Created by David Cordero on 9/3/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

FOUNDATION_EXPORT NSUInteger const dataFetchingTaskInitialCapacity;
FOUNDATION_EXPORT NSString * const HttpMethodPost;
FOUNDATION_EXPORT NSString * const HttpMethodGet;
FOUNDATION_EXPORT NSString * const HttpMethodPatch;
FOUNDATION_EXPORT NSString * const HttpParamLang;
FOUNDATION_EXPORT NSString * const HttpParamAccepLang;


typedef void (^ResultBlock)(NSURLResponse *response, id responseObject, NSError *error);

/**
 ApiClient is a AFNetworkingClient were our network specific behaviour are managed
 */
@interface ApiClient : AFHTTPSessionManager

/**
 The default language to be set in header for all requests.
 */
@property (strong, nonatomic) NSString *defaultLanguage;

/**
 Get a shared instance of this singleton class.
 \return Shared instance of the class.
 */
+ (instancetype)sharedInstance;

/**
 Http GET data from some path.
 
 @param path       Path to get from. Necessary.
 @param parameters Parameters for the request.
 @param result     Block to run when we get response from server.
 
 @return Data task responsible for the get. NOT RUNNING.
 */
- (NSURLSessionDataTask *)getPath:(NSString *)path
                       parameters:(NSDictionary *)parameters
                      resultBlock:(ResultBlock)result;

/**
 Http POST data to some path.
 
 @param path   Path to post to. Necessary.
 @param data   Data to post.
 @param result Block to run when we get response from server.
 
 @return Data task responsible for the post. NOT RUNNING.
 */
- (NSURLSessionDataTask *)postPath:(NSString *)path
                              data:(NSData *)data
                           headers:(NSDictionary *)headers
                       resultBlock:(ResultBlock)result;


/**
 Http PATCH data to some path.
 
 @param path   Path to patch to. Necessary.
 @param data   Data to patch.
 @param result Block to run when we get response from server.
 
 @return Data task responsible for the post. NOT RUNNING.
 */
- (NSURLSessionDataTask *)patchPath:(NSString *)path
                               data:(NSData *)data
                        resultBlock:(ResultBlock)result;

@end
