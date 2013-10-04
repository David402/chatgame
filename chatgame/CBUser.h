//
//  CBUser.h
//  chatgame
//
//  Created by yyjim on 10/4/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CBUser : NSObject
@property (nonatomic, copy) NSString *name;
@end

@interface CBUserRobot : CBUser
@property (nonatomic, copy) NSArray *phrases;
+ (NSArray *)robots;
- (NSString *)randomPhrase;
@end

@interface AngelaRobot : CBUserRobot
@end

