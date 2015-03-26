//
//  NSString+Additional.h
//

@import Foundation;

@interface NSString (Additional)

- (BOOL)endsWith:(NSString *)string;

- (BOOL)startsWith:(NSString *)string;

- (NSUInteger)numberOfOccurencesOfString:(NSString *)string;

@end
