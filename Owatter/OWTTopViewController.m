//
//  OWTTopViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/19.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTTopViewController.h"

@interface OWTTopViewController ()
@property (weak, nonatomic) IBOutlet UIButton *owatterButton;

@end

@implementation OWTTopViewController

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
    
    UIColor* mainColor = [UIColor colorWithRed:0.981 green:0.491 blue:0.118 alpha:1.000];
    [self.owatterButton setBorderColor:mainColor borderWidth:1.0f cornerRadius:5.0f];
    [self.owatterButton setTitleColor:mainColor forState:UIControlStateNormal];
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

@end
