//
//  NSMutableDictionary+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSMutableDictionary+CB.h"

@implementation NSMutableDictionary (CB)
- (NSMutableDictionary *)mergeWithDictionary:(NSDictionary *)dictionary
{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self setObject:obj forKey:key];
    }];
    return self;
}

- (NSMutableDictionary *)remapKeysUsingBlock:(id (^)(id key, id value))block
{
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:[self count]];
    for (id key in self) {
        id value = [self objectForKey:key];
        id newKey = block(key, value);
        if (newKey)
            [ret setObject:value forKey:newKey];
    }
    return ret;
}

- (void)setObjectSafely:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject == nil || aKey == nil)
        return;
    
    [self setObject:anObject forKey:aKey];
}
@end
