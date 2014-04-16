//
//  OWTHistoryViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/19.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTHistoryViewController.h"
#import "OWTCell.h"
#import "OWTDataManager.h"

@interface OWTHistoryViewController ()
<OWTThanksCellDelegate, OWTPostCellDelegate>


@property (nonatomic) NSArray* dataSource;

@property (nonatomic) OWTTweet* postTweet;
@property (nonatomic) UITextView* postTextView;

@end

@implementation OWTHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [OWTTweet findAllSortedBy:@"createdAt" ascending:NO];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = refreshControl;
    [refreshControl addTarget:self action:@selector(refreshOccured:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(didFinishDataSync:)
                   name:OWTDataManagerDidFinishSync
                 object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)refreshOccured:(id)sender
{
    [[OWTDataManager sharedInstance] syncData];
}
- (void)didFinishDataSync:(NSNotification*)notification
{
    self.dataSource = [OWTTweet findAllSortedBy:@"createdAt" ascending:NO];
    [self.tableView reloadData];
    
    if (self.refreshControl.refreshing) {
        [self.refreshControl endRefreshing];
    }
}




- (BOOL)isTweetCell:(OWTTweet*)tweet row:(int)row
{
    return YES;
}

- (CGFloat)heightWithMessage:(NSString*)message widht:(CGFloat)width
{
    CGRect rect = [message boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    return rect.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OWTTweet* tweet = self.dataSource[section];
    if (   (tweet.messages.count == 1 &&  tweet.isOwner)
        || (tweet.messages.count == 2 && !tweet.isOwner)
        || (tweet.messages.count == 3 &&  tweet.isOwner)
        || (tweet.messages.count == 4)
        ) {
        return tweet.messages.count + 2;
    }
    return tweet.messages.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWTTweet* tweet = self.dataSource[indexPath.section];
    if (indexPath.row == 0) {
        return 20 + [self heightWithMessage:tweet.content widht:243] + 21;
    }
    if (tweet.messages.count >= indexPath.row) {
        OWTMessage* message = tweet.messages[ indexPath.row - 1];
        return 20 + [self heightWithMessage:message.content widht:203] + 21;
    }
    if (indexPath.row == 2) {
        return 42;
    }
    if (indexPath.row >= 5) {
        return 42;
    }
    
    return 100;
}

- (void)configureTweetCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    OWTTweet* tweet = self.dataSource[indexPath.section];
    UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
    UILabel* nameLabel     = (UILabel*)[cell viewWithTag:2];
    UILabel* contentLabel  = (UILabel*)[cell viewWithTag:3];
    
    [imageView setImageWithURL:[NSURL URLWithString:tweet.profImagePath] placeholderImage:nil options:SDWebImageRetryFailed];
    nameLabel.text = tweet.name;
    contentLabel.text = tweet.content;
}


- (void)configureMessageCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    OWTTweet* tweet = self.dataSource[indexPath.section];
    OWTMessage* message = [[tweet messages] objectAtIndex:indexPath.row - 1];
    
    UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
    UILabel* nameLabel     = (UILabel*)[cell viewWithTag:2];
    UILabel* contentLabel  = (UILabel*)[cell viewWithTag:3];
    HYCharacterLabel* nameImageLabel = (HYCharacterLabel*)[cell viewWithTag:4];
    

    [imageView setImageWithURL:[NSURL URLWithString:message.profImagePath] placeholderImage:nil options:SDWebImageRetryFailed];
    nameLabel.text = message.name;
    contentLabel.text = message.content;
    
    if (message.isHideUser) {
        imageView.hidden = YES;
        nameImageLabel.hidden = NO;
        nameLabel.text = @"-";
    } else {
        imageView.hidden = NO;
        nameImageLabel.hidden = YES;
    }
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    OWTTweet* tweet = self.dataSource[indexPath.section];
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
        [self configureTweetCell:cell atIndexPath:indexPath];
    } else if (tweet.messages.count >= indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
        [self configureMessageCell:cell atIndexPath:indexPath];
        
    } else if (indexPath.row == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"ThanksCell"];
        [(OWTThanksCell*)cell setDelegate:self];

    } else if (indexPath.row == 5){
        cell = [tableView dequeueReusableCellWithIdentifier:@"OwatterCell"];

    } else {
        cell = [tableView
                dequeueReusableCellWithIdentifier:@"PostCell"];
        [(OWTPostCell*)cell setDelegate:self];

    }
    [cell setNeedsDisplay];
    
    return cell;
}


- (void)owtThanksCell:(OWTThanksCell *)cell tappedThanksButton:(id)sender
{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    OWTTweet* tweet = self.dataSource[indexPath.section];
    [tweet sendThanksWithComplited:^(NSError *error) {
        if (error) {
            [error show];
            return;
        }
        
        [self.tableView reloadData];
    }];
}

- (void)owtPostCell:(OWTPostCell *)cell
    didBeginEditing:(id)sender
{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    self.postTweet = self.dataSource[ indexPath.section ];
    self.postTextView = sender;
}

- (void)owtPostCell:(OWTPostCell *)cell
      didEndEditing:(id)sender
{
    self.postTweet = nil;
    self.postTextView = nil;
}

- (void)owtPostCell:(OWTPostCell *)cell tappedSendButton:(UIButton*)sender
{
    sender.enabled = NO;
    
    [self.postTweet sendMessage:[cell postMessage] complited:^(NSError *error) {
        
        sender.enabled = YES;
        
        if (error) {
            [error show];
            return;
        }
        
        [self.tableView reloadData];
    }];
}


- (IBAction)tappedTableView:(id)sender {
    if (self.postTextView) {
        [self.postTextView resignFirstResponder];
    }
}


@end
