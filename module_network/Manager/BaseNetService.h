
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface BaseNetService : NSObject

@property (nonatomic, strong) AFHTTPSessionManager            *httpClient;

- (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(NSDictionary *)params
                     progress:(void (^)(NSProgress *downloadProgress))downloadProgress
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)params
                      progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)params
                     fileBlock:(void(^)(id <AFMultipartFormData> formData))file
                      progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)PUT:(NSString *)url
                   parameters:(NSDictionary *)params
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)DELETE:(NSString *)url
                      parameters:(NSDictionary *)params
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


+ (NSDictionary *)commonPara;

+ (AFHTTPSessionManager *)getManagerWithBaseUrl:(NSURL *)url;

@end

