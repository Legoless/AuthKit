//
//  UIDevice+DeviceInfo.h
//

#import <UIKit/UIKit.h>

#define isWideScreen ([[UIDevice currentDevice] isWidescreen])

/*!
 * Device family enum
 */
typedef NS_ENUM(NSUInteger, UIDeviceFamily)
{
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
};

/*!
 * Category displays detailed information about current device
 */
@interface UIDevice (DeviceInfo)

/*!
 * Returns YES if device is iPhone.
 */
- (BOOL)isiPhone;

/*!
 * Returns YES if device is iPod.
 */
- (BOOL)isiPod;

/*!
 * Returns YES if device is iPad.
 */
- (BOOL)isiPad;

/*!
 * Returns if the device is iPhone 5 or iPod touch that has widescreen display of 16:9 ratio.
 */
- (BOOL)isWidescreen;

/*!
 * Returns formatted consumer name of Apple device
 */
- (NSString *)modelIdentifier;

/*!
 * Returns model name.
 */
- (NSString *)modelName;

/*!
 * Returns device family of the device
 */
- (UIDeviceFamily)deviceFamily;

/**
 *  Returns specific system information by name
 *
 *  @param name type specifier
 *
 *  @return system information in human readable format
 */
- (NSString *)systemInfoByName:(NSString *)name;

/*!
 *  Returns YES if target is currently being tested
 *
 *  @return YES if running tests
 */
- (BOOL)isRunningTests;

@end
