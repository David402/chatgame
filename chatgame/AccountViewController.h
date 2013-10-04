//
//  AccountViewController.h
//  chatgame
//
//  Created by David Liu on 2/1/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatUser;
@interface AccountViewController : UIViewController

+ (AccountViewController *)shared;
@property (nonatomic, retain, readonly) ChatUser *user;
@end
