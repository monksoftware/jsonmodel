//
//  MSJSONModelError.m
//  MSJSONModel
//

#import "MSJSONModelError.h"

NSString* const MSJSONModelErrorDomain = @"MSJSONModelErrorDomain";
NSString* const kMSJSONModelMissingKeys = @"kMSJSONModelMissingKeys";
NSString* const kMSJSONModelTypeMismatch = @"kMSJSONModelTypeMismatch";
NSString* const kMSJSONModelKeyPath = @"kMSJSONModelKeyPath";

@implementation MSJSONModelError

+(id)errorInvalidDataWithMessage:(NSString*)message
{
    message = [NSString stringWithFormat:@"Invalid JSON data: %@", message];
    return [MSJSONModelError errorWithDomain:MSJSONModelErrorDomain
                                      code:kMSJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
}

+(id)errorInvalidDataWithMissingKeys:(NSSet *)keys
{
    return [MSJSONModelError errorWithDomain:MSJSONModelErrorDomain
                                      code:kMSJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:@"Invalid JSON data. Required JSON keys are missing from the input. Check the error user information.",kMSJSONModelMissingKeys:[keys allObjects]}];
}

+(id)errorInvalidDataWithTypeMismatch:(NSString*)mismatchDescription
{
    return [MSJSONModelError errorWithDomain:MSJSONModelErrorDomain
                                      code:kMSJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:@"Invalid JSON data. The JSON type mismatches the expected type. Check the error user information.",kMSJSONModelTypeMismatch:mismatchDescription}];
}

+(id)errorBadResponse
{
    return [MSJSONModelError errorWithDomain:MSJSONModelErrorDomain
                                      code:kMSJSONModelErrorBadResponse
                                  userInfo:@{NSLocalizedDescriptionKey:@"Bad network response. Probably the JSON URL is unreachable."}];
}

+(id)errorBadJSON
{
    return [MSJSONModelError errorWithDomain:MSJSONModelErrorDomain
                                      code:kMSJSONModelErrorBadJSON
                                  userInfo:@{NSLocalizedDescriptionKey:@"Malformed JSON. Check the MSJSONModel data input."}];
}

+(id)errorModelIsInvalid
{
    return [MSJSONModelError errorWithDomain:MSJSONModelErrorDomain
                                      code:kMSJSONModelErrorModelIsInvalid
                                  userInfo:@{NSLocalizedDescriptionKey:@"Model does not validate. The custom validation for the input data failed."}];
}

+(id)errorInputIsNil
{
    return [MSJSONModelError errorWithDomain:MSJSONModelErrorDomain
                                      code:kMSJSONModelErrorNilInput
                                  userInfo:@{NSLocalizedDescriptionKey:@"Initializing model with nil input object."}];
}

- (instancetype)errorByPrependingKeyPathComponent:(NSString*)component
{
    // Create a mutable  copy of the user info so that we can add to it and update it
    NSMutableDictionary* userInfo = [self.userInfo mutableCopy];

    // Create or update the key-path
    NSString* existingPath = userInfo[kMSJSONModelKeyPath];
    NSString* separator = [existingPath hasPrefix:@"["] ? @"" : @".";
    NSString* updatedPath = (existingPath == nil) ? component : [component stringByAppendingFormat:@"%@%@", separator, existingPath];
    userInfo[kMSJSONModelKeyPath] = updatedPath;

    // Create the new error
    return [MSJSONModelError errorWithDomain:self.domain
                                      code:self.code
                                  userInfo:[NSDictionary dictionaryWithDictionary:userInfo]];
}

@end
