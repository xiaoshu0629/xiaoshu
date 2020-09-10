
#import "BaseNetService.h"

@implementation BaseNetService

- (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(NSDictionary *)params
                     progress:(void (^)(NSProgress *downloadProgress))downloadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.httpClient GET:url parameters:params progress:downloadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)params
                      progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.httpClient POST:url parameters:params progress:uploadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)params
                     fileBlock:(void(^)(id <AFMultipartFormData> formData))file
                      progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.httpClient POST:url parameters:params constructingBodyWithBlock:file progress:uploadProgress success:success failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)url
                   parameters:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.httpClient PUT:url parameters:params success:success failure:failure];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)url
                      parameters:(NSDictionary *)params
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.httpClient DELETE:url parameters:params success:success failure:failure];
}

+ (NSDictionary *)commonPara
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    return para;
}

+ (AFHTTPSessionManager *)getManagerWithBaseUrl:(NSURL *)url
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    return manager;
}

@end
