//
//  OWTCreateReplyMessageViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/17.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTCreateReplyMessageViewController.h"

#import "OWTCreateReceiveViewController.h"

#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface OWTCreateReplyMessageViewController ()
@property (weak, nonatomic) IBOutlet UITextView *messageTextField;

@property (nonatomic) BOOL isTweetDone;

@property (nonatomic) ACAccountStore *accountStore;

@end

@implementation OWTCreateReplyMessageViewController

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
    
    [_messageTextField setBorderColor:nil borderWidth:0 cornerRadius:2.0f];

    _accountStore = [[ACAccountStore alloc] init];
    
    [_messageTextField becomeFirstResponder];
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
        NSString* message = self.messageTextField.text;
        
        NSError* error;
        if (! [self.tweet.class validateMessage:message error:&error]) {
            [error show];
            return NO;
        }
        
        if (self.isTweetDone) {
            return YES;
        } else {
            
            [self performTweetPost];
            
            return NO;
        }
        
    }
    
    return YES;
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


- (void)performTweetPost
{
    // Twitterへの投稿
    
    if (! [SLComposeViewController
         isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        [UIAlertView showTitle:@"Twitterアカウントが設定されていません" message:@"iPhoneの設定からTwitterアカウントを設定してから再度投稿してください"];
        return;
    
    }
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [self sendTweet];
    return;
    
    ACAccountType *twitterAccountType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:
     ACAccountTypeIdentifierTwitter];
    
    [self.accountStore
     requestAccessToAccountsWithType:twitterAccountType
     options:NULL
     completion:^(BOOL granted, NSError *error) {
         if (granted) {
             //  Step 2:  Create a request
             NSArray *twitterAccounts =
             [self.accountStore accountsWithAccountType:twitterAccountType];
             NSURL *url = [NSURL URLWithString:@"https://api.twitter.com"
                           @"/1.1/statuses/update.json"];
             NSDictionary *params = @{@"status" : S(@"%@ #owatter", self.tweet.content) };
             SLRequest *request =
             [SLRequest requestForServiceType:SLServiceTypeTwitter
                                requestMethod:SLRequestMethodPOST
                                          URL:url
                                   parameters:params];
             
             //  Attach an account to the request
             [request setAccount:[twitterAccounts lastObject]];
             
             //  Step 3:  Execute the request
             [request performRequestWithHandler:
              ^(NSData *responseData,
                NSHTTPURLResponse *urlResponse,
                NSError *error) {
                  
                  
                  if (responseData) {
                      if (urlResponse.statusCode >= 200 &&
                          urlResponse.statusCode < 300) {
                          
                          NSError *jsonError;
                          NSDictionary *responseObject =
                          [NSJSONSerialization
                           JSONObjectWithData:responseData
                           options:NSJSONReadingAllowFragments error:&jsonError];
                          if (responseObject) {
                              NSLog(@"Response: %@\n", responseObject);
                              
                              [self sendTweet];
                              
                          }
                          else {
                              dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
                              // Our JSON deserialization went awry
                              NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                              [error show];
                          }
                      }
                      else {
                          dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
                          // The server did not respond ... were we rate-limited?
                          NSLog(@"The response status code is %lu",
                                urlResponse.statusCode);
                      }
                  } else {
                      dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
                  }
              }];
         }
         else {
             dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD dismiss]; });
             // Access was not granted, or an error occurred
             NSLog(@"%@", [error localizedDescription]);
             [error show];
         }
     }];
}

- (void)sendTweet
{
    // サーバに送る
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"json":@"1",
                                 @"tweet": self.tweet.content,
                                 @"reply": self.messageTextField.text,
                                 };
    [manager POST:@"http://owatter.hrk-ys.net/tweet/" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (IBAction)tappedView:(id)sender {
    if (self.messageTextField.isFirstResponder)
        [self.messageTextField resignFirstResponder];
}

@end
