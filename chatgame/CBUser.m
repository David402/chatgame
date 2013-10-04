//
//  CBUser.m
//  chatgame
//
//  Created by yyjim on 10/4/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import "CBToolkit.h"
#import "CBUser.h"

#define BUNDLE_DIRECTORY_PATH(bundle_name) \
    [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundle_name]

@implementation CBUser
@end

@implementation CBUserRobot
+ (NSArray *)robots
{
    NSArray *array = [NSArray arrayWithContentsOfFile:BUNDLE_DIRECTORY_PATH(@"robots.plist")];
    NSArray *robots = [array collect:^id(NSDictionary *info) {
        CBUserRobot *u = [[[CBUserRobot alloc] init] autorelease];
        u.name = [info objectForKey:@"name"];
        u.phrases = [info objectForKey:@"phrases"];
        return u;
    }];
    return robots;
}

- (NSString *)randomPhrase
{
    NSUInteger randomIndex = arc4random() % [self.phrases count];
    return [self.phrases objectAtIndex:randomIndex];
}
@end
