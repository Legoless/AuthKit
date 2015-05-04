//
//  AKInterfaceLoginSource.h
//  Pods
//
//  Created by Dal Rupnik on 04/05/15.
//
//

/*!
 * Interface login source can be used by AKAuthViewController instances to display UI
 */
@protocol AKInterfaceLoginSource <NSObject>

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
