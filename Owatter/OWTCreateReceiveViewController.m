//
//  OWTCreateReceiveViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/18.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTCreateReceiveViewController.h"

@interface OWTCreateReceiveViewController ()
@property (weak, nonatomic) IBOutlet UITextView *replyMessageTextView;

@end

@implementation OWTCreateReceiveViewController

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
    
    OWTMessage* message = [self.tweet.messages objectAtIndex:0];
    self.replyMessageTextView.text = message.content;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)tappedClose:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
