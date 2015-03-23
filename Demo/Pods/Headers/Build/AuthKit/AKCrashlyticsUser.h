#import "JSONModel.h"

@interface AKCrashlyticsUser : JSONModel

@property (nonatomic, strong) NSString<Optional>* email;
@property (nonatomic, strong) NSString<Optional>* name;
@property (nonatomic, strong) NSString<Optional>* password;
@property (nonatomic, strong) NSString<Optional>* token;
@property (nonatomic, strong) NSString<Optional>* userID;

@property (nonatomic, strong) NSArray<Optional>* organizations;

@end
