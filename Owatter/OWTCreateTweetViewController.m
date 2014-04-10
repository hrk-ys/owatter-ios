//
//  OWTCreateTweetViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/17.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTCreateTweetViewController.h"
#import "OWTCreateReceiveViewController.h"


@interface OWTCreateTweetViewController ()

@property (nonatomic) NSManagedObjectContext* context;
@property (nonatomic) OWTTweet* tweet;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextField;

@property (nonatomic) BOOL isTweetDone;

@end

@implementation OWTCreateTweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tweetTextView setBorderColor:nil borderWidth:0 cornerRadius:2.0f];
    [_messageTextField setBorderColor:nil borderWidth:0 cornerRadius:2.0f];

    self.context = [NSManagedObjectContext context];
    self.tweet = [OWTTweet createInContext:self.context];
    
    [self.tweetTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"post"]) {
        self.tweet.content = self.tweetTextView.text;

        NSError* error;
        if (![self.tweet.class validateContent:self.tweet.content error:&error]
            || ![self.tweet.class validateMessage:self.messageTextField.text error:&error]) {
            
            [error show];
            return NO;
        }
        
        if (self.isTweetDone) {
            return YES;
        } else {
            
            [self sendTweet];
            
            return NO;
        }
    }
    
    return YES;
}


- (void)sendTweet
{
    // サーバに送る
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear
     ];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"json":@"1",
                                 @"tweet": self.tweet.content,
                                 @"reply": self.messageTextField.text,
                                 };
    [manager POST:@"http://app.owatter.hrk-ys.net/api/tweet/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if ([responseObject enableValue:@"error_code"]) {
            
            if ([responseObject integerForKey:@"error_code"] == 4) {
                
                [[OWTAccount sharedInstance] updateSession:^(NSError *error) {
                    if(error) {
                        dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
                        [error show];
                        return ;
                    }
                    
                    [self sendTweet];
                }];
                return;
            }
        }
        
        if ([responseObject enableValue:@"error_message"]) {
            dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
            NSError* error = [NSError errorWithTitle:@"" message:responseObject[@"error_message"]];
            [error show];
            return;
        }
        
        OWTMessage* message = [OWTMessage createInContext:self.tweet.managedObjectContext];
        [message setInfoWithDic:responseObject[@"message"]];
        
        [self.tweet setInfoWithDic:responseObject[@"tweet"]];
        
        self.tweet.messages = [NSOrderedSet orderedSetWithObject:message];
        
        [self.tweet.managedObjectContext saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
            
            
            self.isTweetDone = YES;
            
            [self performSegueWithIdentifier:@"post" sender:nil];
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
        [error show];
    }];
    
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"post"]) {
        OWTCreateReceiveViewController* vc = (OWTCreateReceiveViewController*)segue.destinationViewController;
        vc.tweet = self.tweet;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (UITextField* tf in @[_messageTextField, _tweetTextView]) {
        if (tf.isFirstResponder)
            [tf resignFirstResponder];
    }
}

@end
