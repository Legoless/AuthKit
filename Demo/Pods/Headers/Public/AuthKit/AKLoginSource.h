//
//  Header.h
//  Pods
//
//  Created by Dal Rupnik on 24/07/14.
//
//

@protocol AKLoginSource <NSObject>

/*!
 * Returns source name
 */
- (NSString *)sourceName;

@optional

/*!
 * Class should return dictionary with placeholder text for the class source
 */
- (NSDictionary *)placeholdersForSource;

/*!
 * Returns source tint color
 */
- (UIColor *)sourceTintColor;

/*!
 * Returns source image
 */
- (UIImage *)sourceImage;


@end