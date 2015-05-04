//
// Created by Dal Rupnik on 24/03/15.
//

#import <JSONModel/JSONModel.h>

@class AKClient;

@interface AKUser : JSONModel

@property (nonatomic, copy) NSString<Optional>* email;
@property (nonatomic, copy) NSString<Optional>* name;
@property (nonatomic, copy) NSString<Optional>* token;

@end