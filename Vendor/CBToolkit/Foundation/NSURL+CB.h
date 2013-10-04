//
//  NSURL+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSURL (CB)
- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;
- (NSURL *)URLByChangingSchemeTo:(NSString *)scheme;

- (NSString *)parseHeadAndTail:(NSString **)tail;

- (NSString *)uniqueFilename;
@end
