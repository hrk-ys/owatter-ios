//
//  OWTCreateTweetViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/17.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTCreateTweetViewController.h"
#import "OWTCreateReplyMessageViewController.h"

@interface OWTCreateTweetViewController ()

@property (nonatomic) NSManagedObjectContext* context;
@property (nonatomic) OWTTweet* tweet;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

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
    if ([identifier isEqualToString:@"next"]) {
        self.tweet.content = self.tweetTextView.text;

        NSError* error;
        if ([self.tweet.class validateContent:self.tweet.content error:&error]) {
            return YES;
        }
        
        [error show];
        return NO;
    }
    
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"next"]) {
        OWTCreateReplyMessageViewController* vc = (OWTCreateReplyMessageViewController*)segue.destinationViewController;
        vc.tweet = self.tweet;
    }
}


@end
