//
//  AccountViewController.m
//  chatgame
//
//  Created by David Liu on 2/1/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import "AccountViewController.h"
#import "ChatUser.h"

@interface AccountViewController () <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *userNameInput;
- (IBAction)usernameChanged:(id)sender;

@end

@implementation AccountViewController

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
    [super dealloc];
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
    
    ChatUser *user = [[[ChatUser alloc] init] autorelease];
    user.username = self.userNameInput.text;
    
    
#warning stickers from server
    // get user stickers from server
}
@end
