//
//  NSNotificationCenter+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (CB)
- (void)addObserver:(id)observer
           selector:(SEL)aSelector
             object:(id)anObject
              names:(NSString *)name0, ... NS_REQUIRES_NIL_TERMINATION;
@end