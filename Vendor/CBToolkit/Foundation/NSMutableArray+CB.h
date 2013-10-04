//
//  NSMutableArray+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (CB)
+ (id)arrayWithObject:(id)object count:(NSUInteger)count;
- (void)filterUsingBlock:(BOOL (^)(id))block;
+ (id)arrayWithObject:(id)object count:(NSUInteger)count;
- (id)takeLastObject;
- (void)makeLastObject:(id)i;
- (void)shuffle;
- (void)prependObjects:(NSArray *)additionalObjects;
- (void)replaceObjectAtSafeIndex:(NSUInteger)index withObject:(id)anObject;
@end
