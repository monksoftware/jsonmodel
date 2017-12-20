//
//  MSJSONModelError.h
//  MSJSONModel
//

#import <Foundation/Foundation.h>

/////////////////////////////////////////////////////////////////////////////////////////////
typedef NS_ENUM(int, kMSJSONModelErrorTypes)
{
    kMSJSONModelErrorInvalidData = 1,
    kMSJSONModelErrorBadResponse = 2,
    kMSJSONModelErrorBadJSON = 3,
    kMSJSONModelErrorModelIsInvalid = 4,
    kMSJSONModelErrorNilInput = 5
};

/////////////////////////////////////////////////////////////////////////////////////////////
/** The domain name used for the MSJSONModelError instances */
extern NSString *const MSJSONModelErrorDomain;

/**
 * If the model JSON input misses keys that are required, check the
 * userInfo dictionary of the MSJSONModelError instance you get back -
 * under the kMSJSONModelMissingKeys key you will find a list of the
 * names of the missing keys.
 */
extern NSString *const kMSJSONModelMissingKeys;

/**
 * If JSON input has a different type than expected by the model, check the
 * userInfo dictionary of the MSJSONModelError instance you get back -
 * under the kMSJSONModelTypeMismatch key you will find a description
 * of the mismatched types.
 */
extern NSString *const kMSJSONModelTypeMismatch;

/**
 * If an error occurs in a nested model, check the userInfo dictionary of
 * the MSJSONModelError instance you get back - under the kMSJSONModelKeyPath
 * key you will find key-path at which the error occurred.
 */
extern NSString *const kMSJSONModelKeyPath;

/////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Custom NSError subclass with shortcut methods for creating
 * the common MSJSONModel errors
 */
@interface MSJSONModelError : NSError

@property (strong, nonatomic) NSHTTPURLResponse *httpResponse;

@property (strong, nonatomic) NSData *responseData;

/**
 * Creates a MSJSONModelError instance with code kMSJSONModelErrorInvalidData = 1
 */
+ (id)errorInvalidDataWithMessage:(NSString *)message;

/**
 * Creates a MSJSONModelError instance with code kMSJSONModelErrorInvalidData = 1
 * @param keys a set of field names that were required, but not found in the input
 */
+ (id)errorInvalidDataWithMissingKeys:(NSSet *)keys;

/**
 * Creates a MSJSONModelError instance with code kMSJSONModelErrorInvalidData = 1
 * @param mismatchDescription description of the type mismatch that was encountered.
 */
+ (id)errorInvalidDataWithTypeMismatch:(NSString *)mismatchDescription;

/**
 * Creates a MSJSONModelError instance with code kMSJSONModelErrorBadResponse = 2
 */
+ (id)errorBadResponse;

/**
 * Creates a MSJSONModelError instance with code kMSJSONModelErrorBadJSON = 3
 */
+ (id)errorBadJSON;

/**
 * Creates a MSJSONModelError instance with code kMSJSONModelErrorModelIsInvalid = 4
 */
+ (id)errorModelIsInvalid;

/**
 * Creates a MSJSONModelError instance with code kMSJSONModelErrorNilInput = 5
 */
+ (id)errorInputIsNil;

/**
 * Creates a new MSJSONModelError with the same values plus information about the key-path of the error.
 * Properties in the new error object are the same as those from the receiver,
 * except that a new key kMSJSONModelKeyPath is added to the userInfo dictionary.
 * This key contains the component string parameter. If the key is already present
 * then the new error object has the component string prepended to the existing value.
 */
- (instancetype)errorByPrependingKeyPathComponent:(NSString *)component;

/////////////////////////////////////////////////////////////////////////////////////////////
@end
