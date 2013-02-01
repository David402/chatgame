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
@interface ChatViewController : UIViewController

@property (nonatomic, retain) HPGrowingTextView *chatView;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) HPGrowingTextView *textView;
@property (nonatomic, retain) UITableView *stickerTable;

- (id)initWithUser:(ChatUser *)user andFriend:(ChatUser *)user;

@end
