//
//  NSIndexSet+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSIndexSet+CB.h"

@implementation NSIndexSet (CB)
+ (NSIndexSet *)indexSetWithIndices:(NSUInteger)count, ...
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    
    va_list args;
    va_start(args, count);
    for (NSUInteger i=0; i<count; i++) {
        NSUInteger index = va_arg(args, NSUInteger);
        [indexSet addIndex:index];
    }
    va_end(args);
    return [[[NSIndexSet alloc] initWithIndexSet:indexSet] autorelease];
}
@end
