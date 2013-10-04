//
//  NSArray+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (CB)
+ (id)arrayWithObject:(id)anObject times:(NSUInteger)times;
- (NSArray *)collect:(id (^)(id))block;
- (NSArray *)collectWithIndex:(id (^)(NSUInteger, id))block;
- (id)injectMemo:(id)memo block:(id (^)(id memo, id obj))block;

- (id)find:(BOOL (^)(id))block;
- (id)scan:(id (^)(id))block;
- (NSInteger)findIndex:(BOOL (^)(id))block;
- (NSArray *)select:(BOOL (^)(id))block;
- (NSArray *)reject:(BOOL (^)(id))block;
- (BOOL)any:(BOOL (^)(id))block;
- (BOOL)all:(BOOL (^)(id))block;
- (void)each:(void (^)(id obj))block;
- (void)eachWithIndex:(void (^)(int index, id obj))block;

- (id)firstObject;
- (id)objectAtSafeIndex:(NSInteger)index;
- (NSArray *)subarrayWithSafeRange:(NSRange)range;
- (NSArray *)reversed;
- (NSArray *)shuffled;
- (NSMutableArray *)mutableArray;
- (NSArray *)arrayByPrependingObject:(id)anObject;
- (NSMutableArray *)arrayByRemovingObjectsInArray:(NSArray *)removals;
@end
