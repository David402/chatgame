//
//  UIScreen+CB.m
//  PicCollage
//
//  Created by yyjim on 12/7/12.
//
//  Reference from: https://github.com/soffes/sstoolkit

#import "UIScreen+CB.h"

@implementation UIScreen (CB)

- (BOOL)isRetinaDisplay {
	static dispatch_once_t predicate;
	static BOOL answer;
    
	dispatch_once(&predicate, ^{
		answer = ([self respondsToSelector:@selector(scale)] && [self scale] == 2);
	});
	return answer;
}

@end
