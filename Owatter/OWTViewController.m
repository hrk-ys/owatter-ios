//
//  OWTViewController.m
//  Owatter
//
//  Created by Hiroki Yoshifuji on 2014/03/13.
//  Copyright (c) 2014年 Hiroki Yoshifuji. All rights reserved.
//


#import "OWTViewController.h"
#import "OWTAppDelegate.h"

@interface OWTViewController ()

@end

@implementation OWTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [(OWTAppDelegate*)[[UIApplication sharedApplication] delegate] presentLoginViewController:self animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [(OWTAppDelegate*)[[UIApplication sharedApplication] delegate] presentLoginViewController:self animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
