//
//  MSJSONModel+networking.m
//  MSJSONModel
//

#import "MSJSONModel+networking.h"
#import "MSJSONHTTPClient.h"

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wdeprecated-implementations"

BOOL _isLoading;

@implementation MSJSONModel(Networking)

@dynamic isLoading;

-(BOOL)isLoading
{
    return _isLoading;
}

-(void)setIsLoading:(BOOL)isLoading
{
    _isLoading = isLoading;
}

-(instancetype)initFromURLWithString:(NSString *)urlString completion:(MSJSONModelBlock)completeBlock
{
    id placeholder = [super init];
    __block id blockSelf = self;

    if (placeholder) {
        //initialization
        self.isLoading = YES;

        [MSJSONHTTPClient getJSONFromURLWithString:urlString
                                      completion:^(NSDictionary *json, MSJSONModelError* e) {

                                          MSJSONModelError* initError = nil;
                                          blockSelf = [self initWithDictionary:json error:&initError];

                                          if (completeBlock) {
                                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                                                  completeBlock(blockSelf, e?e:initError );
                                              });
                                          }

                                          self.isLoading = NO;

                                      }];
    }
    return placeholder;
}

+ (void)getModelFromURLWithString:(NSString*)urlString completion:(MSJSONModelBlock)completeBlock
{
    [MSJSONHTTPClient getJSONFromURLWithString:urlString
                                  completion:^(NSDictionary* jsonDict, MSJSONModelError* err)
    {
        MSJSONModel* model = nil;

        if(err == nil)
        {
            model = [[self alloc] initWithDictionary:jsonDict error:&err];
        }

        if(completeBlock != nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                completeBlock(model, err);
            });
        }
    }];
}

+ (void)postModel:(MSJSONModel*)post toURLWithString:(NSString*)urlString completion:(MSJSONModelBlock)completeBlock
{
    [MSJSONHTTPClient postJSONFromURLWithString:urlString
                                   bodyString:[post toJSONString]
                                   completion:^(NSDictionary* jsonDict, MSJSONModelError* err)
    {
        MSJSONModel* model = nil;

        if(err == nil)
        {
            model = [[self alloc] initWithDictionary:jsonDict error:&err];
        }

        if(completeBlock != nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                completeBlock(model, err);
            });
        }
    }];
}

@end
