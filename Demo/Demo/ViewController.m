//
//  ViewController.m
//  Demo
//
//  Created by Dal Rupnik on 17/06/14.
//  Copyright (c) 2014 arvystate.net. All rights reserved.
//

#import <AuthKit/AuthKit.h>
#import <AuthKit/AKAuthViewController.h>

#import "ViewController.h"

@interface ViewController () <AKAuthViewControllerDelegate>

@property (nonatomic, strong) AKAuthViewController *authVC;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //
    // Create authorization view controller, default initializer uses shared instance of AKClientManager to grab
    // login sources.
    //

    self.authVC = [[AKAuthViewController alloc] init];
    self.authVC.delegate = self;
    
    self.authVC.headerImageView.image = [UIImage imageNamed:@"lock-icon"];
}

- (IBAction)loginAuthKitButtonTap:(UIButton *)sender
{
    [self presentViewController:self.authVC animated:YES completion:nil];
}

#pragma mark - AKAuthViewControllerDelegate

- (void)authViewControllerDidFinish:(id)authViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
