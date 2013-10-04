//
//  NSOperationQueue+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (CB)
- (NSArray *)operationsDependentOn:(NSOperation *)op;
@end
