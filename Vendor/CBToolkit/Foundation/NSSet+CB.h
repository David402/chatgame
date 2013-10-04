//
//  NSSet+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSSet (CB)

- (NSSet *)collect:(id (^)(id))block;
- (BOOL)containsObjectEqualTo:(id)anObject;
- (BOOL)containsObjectWhereBlock:(BOOL (^)(id))block;
- (id)findObjectEqualTo:(id)anObject;
- (id)find:(BOOL (^)(id))block;
- (NSMutableSet *)mutableSet;
- (NSSet *)setMinusSet:(NSSet *)set;

@end

