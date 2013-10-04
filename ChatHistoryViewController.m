//
//  ChatHistoryViewController.m
//  chatgame
//
//  Created by yyjim on 10/4/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//
#import "CBUser.h"
#import "AccountViewController.h"
#import "ChatViewController.h"
#import "ChatHistoryViewController.h"

@interface ChatHistoryViewController ()

@end

@implementation ChatHistoryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"xCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"xCell"];
    }
    
    NSString *title = nil;
    NSString *subject = nil;
    switch (indexPath.row) {
        case 0:
            title = @"Mica, Mei & Angela";
            subject = @"老闆很樊";
            break;
        case 1:
            title = @"Mica & Mimi";
            subject = @"How's France";
            break;
        case 2:
            title = @"Mica & Dix";
            subject = @"ex1 or ex2";
            break;
            
        default:
            break;
    }
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subject;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *history = @"Mica: 你知道John什麼時候的飛機嘛？\nAngela: 蛤？不知道！\nmei:OMG！It's so annoying, he never puts his schedule on our calendar... but he's always nagging everyone else to!\nMica: ok...calm down. i just asked him... he's going to US this Sunday.\nMei: Are you joking?! This Sunday? 2 days later?\nMica: Yea....-_- \nAngela:	How about Obama?\nMica: 對啊！他已經在問我Obama的事。。。 \nmei: ugh.... so annoying.  但....... 有時候他也蠻可愛的啦～\nAngela:	我要吐了\n";
    
    ChatUser *user = [[AccountViewController shared] user];
    AngelaRobot *angela = [[[AngelaRobot alloc] init] autorelease];
    ChatViewController *vc = [[[ChatViewController alloc] initWithUser:user andFriend:angela history:history] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
