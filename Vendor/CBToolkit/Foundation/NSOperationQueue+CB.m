//
//  NSOperationQueue+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSArray+CB.h"
#import "NSOperationQueue+CB.h"

@implementation NSOperationQueue (CB)
- (NSArray *)operationsDependentOn:(NSOperation *)dependency
{
    return [[self operations] select:^BOOL(NSOperation *op) {
        return [op.dependencies containsObject:dependency];
    }];
}
@end
