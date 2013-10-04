//
//  NSDictionary+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSString+CB.h"
#import "NSDictionary+CB.h"

@implementation NSDictionary (CB)
+ (NSDictionary *)dictionaryWithBool:(BOOL)_bool forKey:(id)key
{
    return [self dictionaryWithObject:[NSNumber numberWithBool:_bool] forKey:key];
}

- (BOOL)boolValueForKey:(id)key defaultingTo:(BOOL)def
{
    id v = [self objectForKey:key];
    if (!v) return def;
    return [v boolValue];
}

@end
