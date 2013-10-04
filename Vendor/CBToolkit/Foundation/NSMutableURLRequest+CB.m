//
//  NSMutableURLRequest+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSString+CB.h"
#import "NSMutableURLRequest+CB.h"

@implementation NSMutableURLRequest (CB)
- (void)setRequestBodyParams:(NSDictionary *)params
{
    NSMutableArray *keyValueStrings = [NSMutableArray arrayWithCapacity:[params count]];
    for (id key in params) {
        id value = [params objectForKey:key];
        NSAssert([[key description] isKindOfClass:[NSString class]], @"param key description must be string");
        NSAssert([[value description] isKindOfClass:[NSString class]], @"param obj description must be string");
        NSString *keyValueString =
        [NSString stringWithFormat:@"%@=%@",
         [(NSString *)key cgiEscapeUsingEncoding:NSUTF8StringEncoding] ,
         [(NSString *)value cgiEscapeUsingEncoding:NSUTF8StringEncoding]];
        [keyValueStrings addObject:keyValueString];
    }
    NSString *paramsString = [keyValueStrings componentsJoinedByString:@"&"];
    
    // Set http post body
    [self setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Set http header
    [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
}
@end
