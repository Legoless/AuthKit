#import "AKUser.h"

@interface AKCrashlyticsUser : AKUser

@property (nonatomic, copy) NSString<Optional>* password;
@property (nonatomic, copy) NSString<Optional>* userID;

@property (nonatomic, copy) NSArray<Optional>* organizations;

@end
