//
// Created by Dal Rupnik on 21/04/15.
//

#import "AKLinkedInRequestSerializer.h"
#import "NSURL+Parameters.h"


@implementation AKLinkedInRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSMutableURLRequest *mutableRequest = [[super requestBySerializingRequest:request withParameters:parameters error:error] mutableCopy];

    //
    // Append format JSON if it does not have it
    //

    if ([[mutableRequest.URL absoluteString] rangeOfString:@"format=json"].location == NSNotFound)
    {
        mutableRequest.URL = [mutableRequest.URL urlByAppendingParameter:@"format" value:@"json"];
    }

    //
    // Append access token if we have it
    //

    if ([[mutableRequest.URL absoluteString] rangeOfString:@"oauth2_access_token"].location == NSNotFound && self.accessToken.length > 0)
    {
        mutableRequest.URL = [mutableRequest.URL urlByAppendingParameter:@"oauth2_access_token" value:self.accessToken];
    }

    [mutableRequest setValue:@"json" forHTTPHeaderField:@"x-li-format"];

    return mutableRequest;
}

@end