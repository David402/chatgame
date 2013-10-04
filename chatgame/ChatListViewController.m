//
//  SecondViewController.m
//  chatgame
//
//  Created by David Liu on 2/1/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import "ChatListViewController.h"

#import "Utils.h"
#import "Configuration.h"
#import "ChatUser.h"
#import "CBUser.h"
#import "ChatViewController.h"
#import "AccountViewController.h"

@interface ChatListViewController ()
    <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *chatListTable;
@property (retain, nonatomic) NSArray *robots;

@end

@implementation ChatListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Chat List", @"Chat List");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.chatListTable.dataSource = self;
    self.chatListTable.delegate = self;
    self.robots = [CBUserRobot robots];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)dealloc {
    [_chatListTable release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.robots count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StickerCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0,
                                                              WINSIZE.width,
                                                              44)]
                autorelease];
    }
    
//    UIImage *image = [self.user.stickers objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"chat with Cbluers";
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"chat with robot %@", [[self.robots objectAtIndex:indexPath.row - 1] name]];
    }
    
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatUser *user1 = [[[ChatUser alloc] init] autorelease];
    user1.username = @"1";
    user1.stickers = [NSArray array];
    
    ChatUser *me = [[AccountViewController shared] user];
    ChatViewController *chatViewController;
    if (indexPath.row == 0) {
        chatViewController = [[ChatViewController alloc] initWithUser:me andFriends:self.robots];
    } else {
        chatViewController = [[ChatViewController alloc] initWithUser:me andFriend:[self.robots objectAtIndex:indexPath.row - 1]];
        
    }
    
    // Clear selection
    [self.chatListTable deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:chatViewController animated:YES];
}
@end
