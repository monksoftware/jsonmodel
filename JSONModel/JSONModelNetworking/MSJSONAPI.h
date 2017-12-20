//
//  JSONAPI.h
//  MSJSONModel
//

#import <Foundation/Foundation.h>
#import "MSJSONHTTPClient.h"

DEPRECATED_ATTRIBUTE
@interface MSJSONAPI : NSObject

+ (void)setAPIBaseURLWithString:(NSString *)base DEPRECATED_ATTRIBUTE;
+ (void)setContentType:(NSString *)ctype DEPRECATED_ATTRIBUTE;
+ (void)getWithPath:(NSString *)path andParams:(NSDictionary *)params completion:(JSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)postWithPath:(NSString *)path andParams:(NSDictionary *)params completion:(JSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)rpcWithMethodName:(NSString *)method andArguments:(NSArray *)args completion:(JSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)rpc2WithMethodName:(NSString *)method andParams:(id)params completion:(JSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;

@end
