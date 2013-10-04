//
//  NSURL+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSArray+CB.h"
#import "NSString+CB.h"
#import "NSCharacterSet+CB.h"
#import "NSURL+CB.h"

@implementation NSURL (CB)
// Copied from http://stackoverflow.com/questions/6309698/objective-c-how-to-add-query-parameter-to-nsurl
//
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString {
    if (![queryString length])
        return self;
    
    NSString *URLString = [[[NSString alloc] initWithFormat:@"%@%@%@",
                            [self absoluteString],
                            [self query] ? @"&" : @"?",
                            queryString
                            ] autorelease];
    return [NSURL URLWithString:URLString];
}
- (NSURL *)URLByChangingSchemeTo:(NSString *)scheme
{
    NSString *absoluteString = [self absoluteString];
    NSMutableArray *components = [NSMutableArray arrayWithArray:
                                  [absoluteString componentsSeparatedByString:@":"]];
    if ([components count] < 1)
        return self;
    [components replaceObjectAtIndex:0 withObject:scheme];
    return [NSURL URLWithString:[components componentsJoinedByString:@":"]];
}

- (NSString *)parseHeadAndTail:(NSString **)tailOut
{
    NSArray *urlPathComponents = [[self path] componentsSeparatedByString:@"/"];
    urlPathComponents = [urlPathComponents select:^BOOL(id s) {
        return ([(NSString *)s length] > 0);
    }];
    
    // Calculate head & tail
    NSString *head = [urlPathComponents objectAtIndex:0];
    NSString *tail = [[urlPathComponents subarrayWithRange:
                       NSMakeRange(1, [urlPathComponents count] - 1)]
                      componentsJoinedByString:@"/"];
    
    // Return
    *tailOut = tail;
    return head;
}

- (NSString *)uniqueFilename
{
    NSString *urlString = [self absoluteString];
    
    // Remove unwanted characters from URL
    NSArray *urlComponents = [[self absoluteString] componentsSeparatedByCharactersInSet:
                              [NSCharacterSet nonAlphanumericCharacterSet]];
    // Add MD5 hash
    return [NSString stringWithFormat:@"%@_%@",
            [urlComponents componentsJoinedByString:@"_"],
            [urlString md5]];
}
@end
