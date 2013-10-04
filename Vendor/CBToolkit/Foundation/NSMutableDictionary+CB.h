//
//  NSMutableDictionary+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (CB)
- (NSMutableDictionary *)mergeWithDictionary:(NSDictionary *)dictionary;
- (NSMutableDictionary *)remapKeysUsingBlock:(id (^)(id key, id value))block;
- (void)setObjectSafely:(id)anObject forKey:(id<NSCopying>)aKey;
@end
