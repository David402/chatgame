//
//  NSError+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSError+CB.h"

@implementation NSError (CB)

+ (id)errorOnAppDomainWithCode:(NSInteger)code
          localizedDescription:(NSString *)localizedDescription
{
    return [self errorOnAppDomainWithCode:code
                     localizedDescription:localizedDescription
                   localizedFailureReason:nil];
}

+ (id)errorOnAppDomainWithCode:(NSInteger)code
          localizedDescription:(NSString *)localizedDescription
        localizedFailureReason:(NSString *)localizedFailureReason
{
    return [self errorWithDomain:@"app"
                            code:code
            localizedDescription:localizedDescription
          localizedFailureReason:localizedFailureReason];
}

+ (id)errorWithDomain:(NSString *)domain
                 code:(NSInteger)code
 localizedDescription:(NSString *)localizedDescription
localizedFailureReason:(NSString *)localizedFailureReason
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if (localizedDescription)
        [userInfo setValue:localizedDescription forKey:NSLocalizedDescriptionKey];
    
    if (localizedFailureReason)
        [userInfo setValue:localizedFailureReason forKey:NSLocalizedFailureReasonErrorKey];
    
    return [self errorWithDomain:domain code:code userInfo:userInfo];
}

@end
