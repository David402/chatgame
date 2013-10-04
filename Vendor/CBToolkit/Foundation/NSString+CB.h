//
//  NSString+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSString (CB)
- (BOOL)isBlank;
- (BOOL)isNotBlank;
- (NSString *)md5;
- (BOOL)containsString: (NSString*) substring;
- (NSString *)trim;
@end

// http://madebymany.com/blog/url-encoding-an-nsstring-on-ios
// or use stringByAddingPercentEscapesUsingEncoding
//
@interface NSString (CGIEscaping)
-(NSString *)cgiEscapeUsingEncoding:(NSStringEncoding)encoding;
- (NSString *)stringByUnescapingFromURLQuery;
@end
