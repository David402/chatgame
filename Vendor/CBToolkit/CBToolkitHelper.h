//
//  CBHelper.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <Foundation/Foundation.h>

id SAFE_CAST(Class klass, id obj);
id SAFE_CALL(id obj, SEL selector);
float SAFE_FLOAT(id obj);
id SAFE_PROTOCOL(id obj, Protocol *protocol);

#define SAFE_DECL(klass, varName, initValue) \
klass *varName = SAFE_CAST([klass class], initValue);

#define SMART_CAST(klass, obj) ((klass *)SAFE_CAST([klass class], obj))

#define IF_NIL(a, b)        (((a) != nil)? (a) : (b))

// ===========================================================================
#pragma mark - Versioning Compare

#define VERSION_EQUAL_TO(currentV,v)                  ([currentV compare:v options:NSNumericSearch] == NSOrderedSame)
#define VERSION_GREATER_THAN(currentV,v)              ([currentV compare:v options:NSNumericSearch] == NSOrderedDescending)
#define VERSION_GREATER_THAN_OR_EQUAL_TO(currentV,v)  ([currentV compare:v options:NSNumericSearch] != NSOrderedAscending)
#define VERSION_LESS_THAN(currentV,v)                 ([currentV compare:v options:NSNumericSearch] == NSOrderedAscending)
#define VERSION_LESS_THAN_OR_EQUAL_TO(currentV,v)     ([currentV compare:v options:NSNumericSearch] != NSOrderedDescending)

#pragma mark - System Versioning Preprocessor Macros
// See http://stackoverflow.com/questions/3339722/check-iphone-ios-version

#define SYSTEM_VERSION_EQUAL_TO(v)                         VERSION_EQUAL_TO([[UIDevice currentDevice] systemVersion], v)
#define SYSTEM_VERSION_GREATER_THAN(v)                     VERSION_GREATER_THAN([[UIDevice currentDevice] systemVersion], v)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)         VERSION_GREATER_THAN_OR_EQUAL_TO([[UIDevice currentDevice] systemVersion], v)
#define SYSTEM_VERSION_LESS_THAN(v)                        VERSION_LESS_THAN([[UIDevice currentDevice] systemVersion], v)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)            VERSION_LESS_THAN_OR_EQUAL_TO([[UIDevice currentDevice] systemVersion], v)
// ===========================================================================
