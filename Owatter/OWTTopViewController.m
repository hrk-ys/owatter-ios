//
//  OWTTopViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/19.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//

#import "OWTTopViewController.h"

@interface OWTTopViewController ()
@property (weak, nonatomic) IBOutlet UIButton *owatterButton1;
@property (weak, nonatomic) IBOutlet UIButton *owatterButton2;
@property (weak, nonatomic) IBOutlet UIButton *owatterButton3;
@property (weak, nonatomic) IBOutlet UIButton *owatterButton4;
@property (weak, nonatomic) IBOutlet UIView *wrapView;



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
    
    [self.wrapView setBorderColor:nil borderWidth:0 cornerRadius:5.0f];
    
    [self setupButton:_owatterButton1 bgColor:[UIColor colorWithRed:0.300 green:0.702 blue:0.839 alpha:1.000]];
    [self setupButton:_owatterButton2 bgColor:[UIColor colorWithRed:0.304 green:0.680 blue:0.290 alpha:1.000]];
    [self setupButton:_owatterButton3 bgColor:[UIColor colorWithRed:0.806 green:0.236 blue:0.245 alpha:1.000]];
    [self setupButton:_owatterButton4 bgColor:[UIColor colorWithRed:0.207 green:0.464 blue:0.745 alpha:1.000]];
}

- (void)setupButton:(UIButton*)button bgColor:(UIColor*)color
{
    [button setBorderColor:nil borderWidth:0 cornerRadius:5.0f];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    
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
