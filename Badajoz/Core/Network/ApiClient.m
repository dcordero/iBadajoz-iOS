//
//  ApiClient.m
//
//  Created by David Cordero on 9/3/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#import "ApiClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLSessionManager.h"
#import "Configuration.h"
#import "DLog.h"

#pragma mark - Constants

NSUInteger const dataFetchingTaskInitialCapacity = 20;
NSString * const HttpMethodPost     = @"POST";
NSString * const HttpMethodGet      = @"GET";
NSString * const HttpMethodPatch    = @"PATCH";
NSString * const HttpParamLang      = @"lang";
NSString * const HttpParamAccepLang = @"Accept-Language";

static ApiClient *_sharedInstance = nil;
static dispatch_once_t onceToken = 0;

#pragma mark - Implementation

@implementation ApiClient

#pragma mark - Properties

/**
 When default language is set also propagate it to the HTTP headers
 
 @param defaultLanguage The language to use for http requests, fulfilling pattern "^[a-z]{2}$"
 */
- (void)setDefaultLanguage:(NSString *)defaultLanguage
{
    NSInteger max_len = 2;
    NSString *lang = defaultLanguage;
    if (defaultLanguage.length > max_len) {
        lang = [defaultLanguage substringToIndex:max_len];
    }
    _defaultLanguage = lang;
    [self.requestSerializer setValue:lang forHTTPHeaderField:HttpParamAccepLang];
}



#pragma mark - Public

+ (instancetype)sharedInstance
{
    dispatch_once(&onceToken, ^{
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
            _sharedInstance.defaultLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
            
            AFJSONResponseSerializer *jsonSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:0];
            AFHTTPResponseSerializer *httpSerializer = [AFHTTPResponseSerializer serializer];
            
            jsonSerializer.acceptableContentTypes = nil;

            AFCompoundResponseSerializer *compoundSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:@[jsonSerializer, httpSerializer]];
            _sharedInstance.responseSerializer = compoundSerializer;
        }
    });
    
    return _sharedInstance;
}

- (NSURLSessionDataTask *)getPath:(NSString *)path
                       parameters:(NSDictionary *)parameters
                      resultBlock:(ResultBlock)result
{
    if (!result) {
        DLog(@"Result block missing in call to %s", __PRETTY_FUNCTION__);
        return nil;
    }
    
    NSMutableURLRequest *request = [self requestWithMethod:HttpMethodGet forPath:path relativeToURL:self.baseURL parameters:parameters];
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request resultBlock:result];
    return task;
}

- (NSURLSessionDataTask *)postPath:(NSString *)path
                              data:(NSData *)data
                           headers:(NSDictionary *)headers
                       resultBlock:(ResultBlock)result
{
    if (!result) {
        DLog(@"Result block missing in %s", __PRETTY_FUNCTION__);
        return nil;
    }
    
    NSMutableURLRequest *request = [self requestWithMethod:HttpMethodPost forPath:path relativeToURL:self.baseURL parameters:nil];
    [request setHTTPBody:data];
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        [request addValue:value forHTTPHeaderField:key];
    }];
        
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request resultBlock:result];
    return task;
}

- (NSURLSessionDataTask *)patchPath:(NSString *)path
                               data:(NSData *)data
                        resultBlock:(ResultBlock)result
{
    if (!result) {
        DLog(@"Result block missing in %s", __PRETTY_FUNCTION__);
        return nil;
    }
    
    NSMutableURLRequest *request = [self requestWithMethod:HttpMethodPatch forPath:path relativeToURL:self.baseURL parameters:nil];
    [request setHTTPBody:data];
    
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request resultBlock:result];
    return task;
}

#pragma mark - Private

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                   forPath:(NSString *)path
                             relativeToURL:(NSURL *)baseUrl
                                parameters:(NSDictionary *)parameters
{
    NSURL *url = [NSURL URLWithString:path relativeToURL:self.baseURL];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:method];
    
    return [[self.requestSerializer requestBySerializingRequest:request withParameters:parameters error:nil] mutableCopy];
}


- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request resultBlock:(ResultBlock)result
{
    NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            DLog(@"%@", error);
            if (result) {
                result(nil, nil, error);
            }
        } else {
            result(response, responseObject, nil);
        }
    }];
    return task;
}


@end
