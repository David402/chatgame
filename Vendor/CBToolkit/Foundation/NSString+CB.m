//
//  NSString+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
#import "NSString+CB.h"

@implementation NSString (CB)
- (BOOL)isBlank
{
    NSRange range = [self rangeOfCharacterFromSet:[[NSCharacterSet whitespaceCharacterSet]
                                                   invertedSet]];
    return (BOOL)(range.length == 0);
}
- (BOOL)isNotBlank
{
    return ![self isBlank];
}
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    NSString *md5 = [NSString stringWithFormat:
                     @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                     result[0],  result[1],  result[2],  result[3],
                     result[4],  result[5],  result[6],  result[7],
                     result[8],  result[9],  result[10], result[11],
                     result[12], result[13], result[14], result[15]
                     ];
    return md5;
}

- (BOOL)containsString:(NSString*)substring
{
    NSRange range = [self rangeOfString:substring];
    BOOL found = (range.location != NSNotFound );
    return found;
}
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end

// http://madebymany.com/blog/url-encoding-an-nsstring-on-ios
// or use stringByAddingPercentEscapesUsingEncoding
//
@implementation NSString (CGIEscaping)
-(NSString *)cgiEscapeUsingEncoding:(NSStringEncoding)encoding {
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                    (CFStringRef)self,
                                                                    NULL,
                                                                    (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                    CFStringConvertNSStringEncodingToEncoding(encoding));
    NSString *s = [[[NSString alloc] initWithString:(NSString *)stringRef] autorelease];
    CFRelease(stringRef);
    return s;
}

// https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/NSString%2BSSToolkitAdditions.m
// From sstoolkit
- (NSString *)stringByUnescapingFromURLQuery {
	NSString *deplussed = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [deplussed stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
