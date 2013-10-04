//
//  NSMutableArray+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSMutableArray+CB.h"

@implementation NSMutableArray (CB)
- (void)filterUsingBlock:(BOOL (^)(id))block
{
    NSIndexSet *indexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return !block(obj);
    }];
    [self removeObjectsAtIndexes:indexes];
}

+ (id)arrayWithObject:(id)object count:(NSUInteger)count
{
    id array = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i=0; i<count; i++)
        [array addObject:object];
    return array;
}
- (id)takeLastObject
{
    id ret = [[self lastObject] retain];
    // Add checking for iOS4.
    // Checking if any object return before remove last object.
    if (ret)
        [self removeLastObject];
    return [ret autorelease];
}
- (void)makeLastObject:(id)i
{
    [self removeObject:i];
    [self addObject:i];
}

- (NSMutableArray *)mutableArray
{
    return self;
}
- (void)replaceObjectAtSafeIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index < self.count)
        [self replaceObjectAtIndex:(NSUInteger)index withObject:anObject];
}


// Copied from http://stackoverflow.com/questions/791232/canonical-way-to-randomize-an-nsarray-in-objective-c
// Chooses a random integer below n without bias.
// Computes m, a power of two slightly above n, and takes random() modulo m,
// then throws away the random number if it's between n and m.
// (More naive techniques, like taking random() modulo n, introduce a bias
// towards smaller numbers in the range.)
//
static NSUInteger random_below(NSUInteger n) {
    
    NSUInteger m = 1;
    
    // Compute smallest power of two greater than n.
    // There's probably a faster solution than this loop, but bit-twiddling
    // isn't my specialty.
    do {
        m <<= 1;
    } while(m < n);
    
    NSUInteger ret;
    
    do {
        ret = random() % m;
    } while(ret >= n);
    
    return ret;
}

- (void)shuffle
{
    // Copied from http://stackoverflow.com/questions/791232/canonical-way-to-randomize-an-nsarray-in-objective-c
    // http://en.wikipedia.org/wiki/Knuth_shuffle
    
    for(NSUInteger i = [self count]; i > 1; i--) {
        NSUInteger j = random_below(i);
        [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}
- (void)prependObjects:(NSArray *)additionalObjects
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, additionalObjects.count)];
    [self insertObjects:additionalObjects atIndexes:indexSet];
}
@end
