//
//  NSNotificationCenter+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSNotificationCenter+CB.h"

@implementation NSNotificationCenter (CB)
- (void)addObserver:(id)observer
           selector:(SEL)aSelector
             object:(id)anObject
              names:(NSString *)name0, ...
{
    va_list argsList;
    
    if (!name0)
        return;
    [self addObserver:observer selector:aSelector name:name0 object:anObject];
    NSLog(@"name:%@", name0);
    
    va_start(argsList, name0);
    NSString *name;
    while ((name = va_arg(argsList, NSString *))) {
        [self addObserver:observer selector:aSelector name:name object:anObject];
        NSLog(@"name:%@", name);
    }
    va_end(argsList);
}
@end
