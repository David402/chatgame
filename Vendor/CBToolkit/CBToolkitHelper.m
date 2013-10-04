//
//  CBHelper.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "CBToolKitHelper.h"

id SAFE_CAST(Class klass, id obj) {
    return [obj isKindOfClass:klass]? obj : nil;
}
id SAFE_CALL(id obj, SEL selector) {
    if ([obj respondsToSelector:selector])
        return [obj performSelector:selector];
    return nil;
}
id SAFE_PROTOCOL(id obj, Protocol *protocol) {
    return [obj conformsToProtocol:protocol]? obj : nil;
}
float SAFE_FLOAT(id obj) {
    if ([obj respondsToSelector:@selector(floatValue)])
        return [obj floatValue];
    return 0;
}