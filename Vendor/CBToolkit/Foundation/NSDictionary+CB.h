//
//  NSDictionary+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CB)
+ (NSDictionary *)dictionaryWithBool:(BOOL)_bool forKey:(id)key;
- (BOOL)boolValueForKey:(id)key defaultingTo:(BOOL)def;
@end
