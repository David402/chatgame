//
//  AccountViewController.m
//  chatgame
//
//  Created by David Liu on 2/1/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import "ASIFormDataRequest.h"
#import "AccountViewController.h"
#import "ChatUser.h"
#import "JSONKit.h"

@interface AccountViewController ()
<
    UITextFieldDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>

@property (nonatomic, retain, readwrite) ChatUser *user;
@property (retain, nonatomic) IBOutlet UITableView *stickerTable;
@property (retain, nonatomic) IBOutlet UITextField *userNameInput;
- (IBAction)usernameChanged:(id)sender;

@end

@implementation AccountViewController
@synthesize user = _user;

static AccountViewController *shared = nil;
+ (AccountViewController *)shared
{
    @synchronized(self) {
        if (shared == nil) {
            shared = [[super allocWithZone:NULL] init];
        }
    }
    return shared;                                                           
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [[self shared] retain];
}
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (id)retain
{
    return self;
}
- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}
- (oneway void)release
{
}
- (id)autorelease
{
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Account", @"Account");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userNameInput.delegate = self;
    self.userNameInput.returnKeyType = UIReturnKeyDone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_userNameInput release];
    [_stickerTable release];
    [super dealloc];
}

- (ChatUser*)getUser
{
    return self.user;
}

- (IBAction)usernameChanged:(id)sender {
    self.userNameInput.enabled = NO;
    // resign
    [self.userNameInput resignFirstResponder];
    
    ChatUser *user = [[[ChatUser alloc] init] autorelease];
    user.username = self.userNameInput.text;
    

#warning stickers from server
    // get user stickers from server
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key
{
    [self.userNameInput resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.userNameInput.enabled = NO;
    // resign
    [self.userNameInput resignFirstResponder];
    
    self.user = [[[ChatUser alloc] init] autorelease];
    self.user.username = self.userNameInput.text;
    [self getSticker];
    
    // create user
//    NSString *urlString = @"http://battlechat.herokuapp.com/user";
//    NSURL *url = [NSURL URLWithString:urlString];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    [request setDelegate:self];
//    [request setPostValue:self.user.username forKey:@"username"];
//
//    [request startAsynchronous];
}

- (void)getSticker
{
    NSString *urlString = @"http://battlechat.herokuapp.com/stickers/all";
    NSURL *url = [NSURL URLWithString:urlString];
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//    request.requestMethod = @"GET";
//    [request setDelegate:self];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *rs, NSData *data, NSError *error) {
                               NSDictionary *dic = [data objectFromJSONData];
                               NSArray *stickers = [dic objectForKey:@"sticker_types"];
                               __block NSMutableArray *userStickerArray = [NSMutableArray arrayWithCapacity:10];
                               [stickers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                   NSDictionary *stickerInfo = [stickers objectAtIndex:idx];
                                   [userStickerArray addObject:[stickerInfo objectForKey:@"image_url"]];
                               }];
                               self.user.stickers = nil;
                           }];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
    NSDictionary *responseJson = [responseString objectFromJSONString];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
//    LogD(@"request error %@", [request error]);
}


#pragma mark - Table

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
@end
