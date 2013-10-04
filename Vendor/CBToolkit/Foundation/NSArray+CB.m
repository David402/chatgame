//
//  NSArray+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSMutableArray+CB.h"
#import "NSArray+CB.h"

@implementation NSArray (CB)

#pragma mark - Creation methods

+ (id)arrayWithObject:(id)anObject times:(NSUInteger)times
{
    NSMutableArray *a = [NSMutableArray arrayWithCapacity:times];
    for (NSUInteger i=0; i<times; i++) {
        [a addObject:anObject];
    }
    return a;
}

#pragma mark "Enumerable"-type methods

- (NSArray *)collect:(id (^)(id))block
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[self count]];
    for (id i in self) {
        if ((i = block(i)))
            [ret addObject:i];
    }
    return ret;
}
- (NSArray *)collectWithIndex:(id (^)(NSUInteger, id))block
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:[self count]];
    NSUInteger n = 0;
    for (id i in self) {
        if ((i = block(n++, i)))
            [ret addObject:i];
    }
    return ret;
}
- (NSArray *)select:(BOOL (^)(id))block
{
    NSMutableArray *ret = [[[NSMutableArray alloc] init] autorelease];
    for (id i in self)
        if (block(i))
            [ret addObject:i];
    return ret;
    
}
- (NSArray *)reject:(BOOL (^)(id))block
{
    return [self select:^BOOL(id i) {
        return !block(i);
    }];
}

// Returns the first item in the array where block is true
- (id)find:(BOOL (^)(id))block
{
    for (id i in self)
        if (block(i))
            return i;
    return nil;
}
// Returns the return value that is true
- (id)scan:(id (^)(id))block
{
    for (id i in self) {
        id ret = block(i);
        if (ret) return ret;
    }
    return nil;
}

- (NSInteger)findIndex:(BOOL (^)(id))block
{
    NSInteger index = 0;
    for (id i in self) {
        if (block(i))
            return index;
        index++;
    }
    return NSNotFound;
}

- (id)injectMemo:(id)memo block:(id (^)(id memo, id obj))block
{
    for (id i in self)
        memo = block(memo, i);
    return memo;
}
- (BOOL)all:(BOOL (^)(id))block
{
    for (id i in self)
        if (!block(i))
            return NO;
    return YES;
}
- (BOOL)any:(BOOL (^)(id))block
{
    for (id i in self)
        if (block(i))
            return YES;
    return NO;
}
- (void)each:(void (^)(id obj))block
{
    for (id i in self)
        block(i);
}
- (void)eachWithIndex:(void (^)(int index, id obj))block
{
    int index = 0;
    for (id i in self) {
        block(index++, i);
    }
}
- (id)firstObject
{
#ifdef DEBUG
    return [self objectAtIndex:0];
#else
    return [self objectAtSafeIndex:0];
#endif
}
- (id)objectAtSafeIndex:(NSInteger)index
{
    if (index >= 0 && index < [self count])
        return [self objectAtIndex:index];
    return nil;
}

- (NSArray *)subarrayWithSafeRange:(NSRange)wantedRange
{
    NSRange intersectionRange = NSIntersectionRange(NSMakeRange(0, [self count]),
                                                    wantedRange);
    return [self subarrayWithRange:intersectionRange];
}

- (NSArray *)reversed
{
    return [[self reverseObjectEnumerator] allObjects];
}
- (NSArray *)shuffled
{
    NSMutableArray *a = [NSMutableArray arrayWithArray:self];
    [a shuffle];
    return [NSArray arrayWithArray:a];
}

- (NSMutableArray *)mutableArray
{
    return [NSMutableArray arrayWithArray:self];
}
- (NSArray *)arrayByPrependingObject:(id)anObject
{
    return [[NSArray arrayWithObject:anObject] arrayByAddingObjectsFromArray:self];
}
- (NSArray *)arrayByRemovingObjectsInArray:(NSArray *)removals
{
    NSMutableArray *m = [NSMutableArray arrayWithArray:self];
    [m removeObjectsInArray:removals];
    return [NSArray arrayWithArray:m];
}
@end
