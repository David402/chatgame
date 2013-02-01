//
//  User.h
//  chatgame
//
//  Created by David Liu on 2/1/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatUser : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, retain) NSArray *stickers;

@end
