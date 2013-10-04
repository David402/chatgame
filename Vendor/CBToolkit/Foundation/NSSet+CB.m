//
//  NSSet+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSSet+CB.h"

@implementation NSSet (CB)

- (NSSet *)collect:(id (^)(id))block
{
    NSMutableSet *ret = [NSMutableSet setWithCapacity:[self count]];
    for (id i in self) {
        if ((i = block(i)))
            [ret addObject:i];
    }
    return ret;
}

- (BOOL)containsObjectEqualTo:(id)anObject
{
    return [self findObjectEqualTo:anObject] != nil;
}

- (BOOL)containsObjectWhereBlock:(BOOL (^)(id))block
{
    for (id i in self) {
        if (block(i))
            return YES;
    }
    return NO;
}

- (id)findObjectEqualTo:(id)anObject
{
    __block id ret = nil;
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([anObject isEqual:obj]) {
            ret = obj;
            *stop = YES;
        }
    }];
    return ret;
}

// Returns the first item in the array where block is true
- (id)find:(BOOL (^)(id))block
{
    for (id i in self)
        if (block(i))
            return i;
    return nil;
}

- (NSMutableSet *)mutableSet
{
    return [NSMutableSet setWithSet:self];
}

- (NSSet *)setMinusSet:(NSSet *)set
{
    NSMutableSet *mutable = [self mutableSet];
    [mutable minusSet:set];
    return [NSSet setWithSet:mutable];
}

@end

