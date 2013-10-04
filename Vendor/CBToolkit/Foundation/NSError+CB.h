//
//  NSError+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSError (CB)

+ (id)errorOnAppDomainWithCode:(NSInteger)code
          localizedDescription:(NSString *)localizedDescription;

+ (id)errorOnAppDomainWithCode:(NSInteger)code
          localizedDescription:(NSString *)localizedDescription
        localizedFailureReason:(NSString *)localizedFailureReason;

+ (id)errorWithDomain:(NSString *)domain
                 code:(NSInteger)code
 localizedDescription:(NSString *)localizedDescription
localizedFailureReason:(NSString *)localizedFailureReason;

@end
