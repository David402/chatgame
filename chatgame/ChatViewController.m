//
//  ChatViewController.m
//  chatgame
//
//  Created by David Liu on 2/1/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import "Utils.h"
#import "Configuration.h"

#import "ChatViewController.h"
#import "HPGrowingTextView.h"
#import "ChatUser.h"
#import "CBUser.h"
#import "StickerCell.h"
#import "ASIFormDataRequest.h"
#import "ChatHistoryViewController.h"
#import "CBToolkit.h"

#define KB_HEIGHT 216
#define STICKER_TABLE_HEIGHT 60

@interface ChatViewController ()
<   UITableViewDataSource,
    UITableViewDelegate,
    HPGrowingTextViewDelegate,
    UITextViewDelegate
>

@property (nonatomic, copy) NSString *history;
@property (nonatomic, retain) ChatUser *user;
@property (nonatomic, retain) CBUserRobot *robot;
@property (nonatomic, retain) NSArray *robots;
@property (nonatomic, retain) NSTimer *refreshTimer;

@end

@implementation ChatViewController
@synthesize user = _user;
@synthesize robot = _robot;

- (id)initWithUser:(ChatUser *)user andFriends:(NSArray *)robots history:(NSString *)history
{
    self = [self init];
    if (self) {
        // Custom initialization
        self.textView = [[[HPGrowingTextView alloc] init] autorelease];
        self.stickerTable = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)
                                                          style:UITableViewStylePlain]
                             autorelease];
        self.user = user;
        self.robots = robots;
        self.history = history;
        
        NSArray *names = [self.robots collect:^id(CBUser *u) {
            return u.name;
        }];
        self.title = [names componentsJoinedByString:@","];
        
        self.navigationItem.rightBarButtonItem =
        [[[UIBarButtonItem alloc] initWithTitle:@"Explore" style:UIBarButtonItemStyleDone target:self action:@selector(handleExploreButtonPressed:)] autorelease];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidChangeFrame:)
                                                     name:UIKeyboardDidChangeFrameNotification
                                                   object:nil];
        
        self.refreshTimer =
        [[NSTimer scheduledTimerWithTimeInterval:1
                                          target:self
                                        selector:@selector(refresh)
                                        userInfo:nil
                                         repeats:YES] retain];
    }
    return self;
}


- (id)initWithUser:(ChatUser *)user andFriend:(CBUserRobot *)robot history:(NSString *)history
{
    return [self initWithUser:user andFriends:@[robot] history:history];
}

- (id)initWithUser:(ChatUser *)user andFriend:(CBUserRobot *)robot
{
    return [self initWithUser:user andFriend:robot history:nil];
}

- (void)handleExploreButtonPressed:(id)sender
{
    ChatHistoryViewController *vc = [[[ChatHistoryViewController alloc] init] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    
    // layout UI elements
    self.view.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
	
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, 40)];
    
	self.textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 40)];
    self.textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	self.textView.minNumberOfLines = 1;
	self.textView.maxNumberOfLines = 10;
	self.textView.returnKeyType = UIReturnKeyGo; //just as an example
	self.textView.font = [UIFont systemFontOfSize:15.0f];
	self.textView.delegate = self;
    self.textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    self.textView.backgroundColor = [UIColor whiteColor];
    
    // textView.text = @"test\n\ntest";
	// textView.animateHeightChange = NO; //turns off animation
    
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame = CGRectMake(5, 0, 248, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    [self.containerView addSubview:imageView];
    [self.containerView addSubview:self.textView];
    [self.containerView addSubview:entryImageView];
    
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
	UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	doneBtn.frame = CGRectMake(self.containerView.frame.size.width - 69, 8, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
	[doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[doneBtn addTarget:self action:@selector(sendText) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
	[self.containerView addSubview:doneBtn];
    
    
    ///////////////////////////////////////////////////////////////////////////
    // Sticker
    ///////////////////////////////////////////////////////////////////////////
//    CGSize stickTableSize = CGSizeMake(STICKER_TABLE_HEIGHT, WINSIZE.width);
//    [self configStickerTable];

    // Chat view
    //
    self.chatView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height - KB_HEIGHT - self.textView.bounds.size.height - 44)];
    self.chatView.delegate = self;
    self.chatView.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
    self.chatView.editable = NO;
    self.chatView.autocorrectionType = UITextAutocorrectionTypeNo;
    self.chatView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.chatView.text = self.history;
    self.chatView.font = [UIFont systemFontOfSize:24];
#if 0
    self.chatView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height - KB_HEIGHT - self.textView.bounds.size.height - 44)];
    self.chatView.delegate = self;
    self.chatView.backgroundColor = [UIColor colorWithRed:219.0f/255.0f green:226.0f/255.0f blue:237.0f/255.0f alpha:1];
    self.chatView.editable = NO;
    self.chatView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
#endif
    
//    [self.view addSubview:self.stickerTable];
    [self.view addSubview:self.chatView];
    [self.view addSubview:self.containerView];
}


- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    CGRect kbFrame;
    [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&kbFrame];
    
    CGRect frame = self.containerView.frame;
    frame.origin.y = self.view.frame.size.height - kbFrame.size.height - frame.size.height;
    self.containerView.frame = frame;
    [self.view addSubview:self.containerView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
    
    self.chatView = nil;
    self.containerView = nil;
    self.textView = nil;
    self.stickerTable = nil;
    self.user = nil;
    self.robot = nil;
    [super dealloc];
}

#pragma mark -

- (void)configStickerTable
{
    self.stickerTable.showsVerticalScrollIndicator = NO;
    self.stickerTable.showsHorizontalScrollIndicator = NO;
    
    CGRect frame = self.stickerTable.frame;
    self.stickerTable.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    {
        frame.origin.x = frame.origin.x;
        frame.origin.y = frame.origin.y;
        frame.size.width = WINSIZE.width;
        frame.size.height = STICKER_TABLE_HEIGHT;
    }
    [self.stickerTable setFrame:frame];
    
    self.stickerTable.rowHeight = STICKER_TABLE_HEIGHT;
    self.stickerTable.backgroundColor = [UIColor clearColor];
    self.stickerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.stickerTable.dataSource = self;
    self.stickerTable.delegate = self;
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.user.stickers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StickerCell";
    
    StickerCell *cell = (StickerCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[StickerCell alloc] initWithFrame:CGRectMake(0, 0,
                                                              STICKER_TABLE_HEIGHT,
                                                              WINSIZE.width)]
                autorelease];
    }
    
    UIImage *image = [self.user.stickers objectAtIndex:indexPath.row];
    cell.thumbnail.image = image;
    
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning add selection action
}

#pragma mark -

double rand_range(double min_n, double max_n)
{
    return (double)rand()/RAND_MAX * (max_n - min_n) + min_n;
}

- (void)sendText
{
    NSString *text = self.textView.text;
    NSString *name = (self.user.username == nil || [self.user.username isEqualToString:@""]) ? @"guest" : self.user.username;
    NSString *newText = [self.chatView.text stringByAppendingFormat:@"%@: %@\n", name, text];
    self.chatView.text = newText;
//    self.chatView.attributedText = @"";
    self.textView.text = @"";
    
    // Scroll to bottom
    [self.chatView scrollRangeToVisible:NSMakeRange([self.chatView.text length], 0)];
    
    // Robot answer
    NSUInteger randomIndex = MAX(arc4random() % [self.robots count], 1);
    for (int i = 0; i < randomIndex; i++) {
        NSUInteger userIndex = arc4random() % [self.robots count];
        CBUserRobot *robot = self.robots[userIndex];
        NSString *robotAnswer = [robot randomPhrase];
        NSString *text = [NSString stringWithFormat:@"%@: %@\n", [robot name], robotAnswer];
        double randDelay = rand_range(0.5, 1.0);
        [self performSelector:@selector(sendWithText:) withObject:text afterDelay:randDelay];
    }
}

- (void)sendWithText:(NSString *)text
{
    if (!text) {
        return;
    }
    
    self.chatView.text = [self.chatView.text stringByAppendingString:text];
    self.textView.text = @"";
    
    // Scroll to bottom
    [self.chatView scrollRangeToVisible:NSMakeRange([self.chatView.text length], 0)];
}

-(void)resignTextView
{
	[self.textView resignFirstResponder];
}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = self.containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	self.containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	// get a rect for the textView frame
	CGRect containerFrame = self.containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	self.containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    if (growingTextView == self.textView) {
        CGRect r = self.containerView.frame;
        r.size.height -= diff;
        r.origin.y += diff;
        self.containerView.frame = r;
    } else if (growingTextView == self.chatView) {
        CGRect r = self.chatView.frame;
        r.size.height -= diff;
        CGFloat minHeight = WINSIZE.height - KB_HEIGHT - STICKER_TABLE_HEIGHT - self.textView.bounds.size.height - 44;
        r.size.height = MAX(r.size.height, minHeight);
//        r.origin.y += diff;
        self.chatView.frame = r;
    }
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView didChangeHeight:(float)height
{
    if (growingTextView == self.chatView) {
        CGFloat minHeight = WINSIZE.height - KB_HEIGHT - STICKER_TABLE_HEIGHT - self.textView.bounds.size.height - 44;
        CGRect r = self.chatView.frame;
        r.size.height = MAX(r.size.height, minHeight);
        self.chatView.frame = r;
        
//        CGFloat offset = self.chatView.internalTextView.contentSize.height - self.chatView.bounds.size.height;
//        CGPoint contentOff = self.chatView.internalTextView.contentOffset;
//        contentOff.y = contentOff.y + offset;
//        self.chatView.internalTextView.contentOffset = contentOff;
    }
}

- (void)refresh
{
    
}

@end
