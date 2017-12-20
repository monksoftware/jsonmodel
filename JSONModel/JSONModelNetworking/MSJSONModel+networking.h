//
//  MSJSONModel+networking.h
//  MSJSONModel
//

#import "MSJSONModel.h"
#import "MSJSONHTTPClient.h"

typedef void (^MSJSONModelBlock)(id model, MSJSONModelError *err) DEPRECATED_ATTRIBUTE;

@interface MSJSONModel (Networking)

@property (assign, nonatomic) BOOL isLoading DEPRECATED_ATTRIBUTE;
- (instancetype)initFromURLWithString:(NSString *)urlString completion:(MSJSONModelBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)getModelFromURLWithString:(NSString *)urlString completion:(MSJSONModelBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)postModel:(MSJSONModel *)post toURLWithString:(NSString *)urlString completion:(MSJSONModelBlock)completeBlock DEPRECATED_ATTRIBUTE;

@end
