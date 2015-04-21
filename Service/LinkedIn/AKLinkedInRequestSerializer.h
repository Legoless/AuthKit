//
// Created by Dal Rupnik on 21/04/15.
//

#import <AFNetworking/AFURLRequestSerialization.h>

@interface AKLinkedInRequestSerializer : AFJSONRequestSerializer

@property (nonatomic, copy) NSString* accessToken;

@end