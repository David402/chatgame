//
//  ChatViewController.h
//  chatgame
//
//  Created by David Liu on 2/1/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HPGrowingTextView;
@class ChatUser;
@class CBUserRobot;
@interface ChatViewController : UIViewController

@property (nonatomic, retain) UITextView *chatView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) HPGrowingTextView *textView;
@property (nonatomic, retain) UITableView *stickerTable;

- (id)initWithUser:(ChatUser *)user andFriend:(CBUserRobot *)robot;
- (id)initWithUser:(ChatUser *)user andFriend:(CBUserRobot *)robot history:(NSString *)history;

- (id)initWithUser:(ChatUser *)user andFriends:(NSArray *)robots;

@end
