//
//  ViewController.m
//  Delegation2
//
//  Created by Alexandre THOMAS on 31/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController () <LoginViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launchLogin
{
    LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    lvc.delegate = self; // set the delegate
    [self showViewController:lvc sender:nil];
    
    // or in case we are in a navigation controller
    //[self presentViewController:lvc animated:YES completion:nil];
}

- (void)loginViewController:(LoginViewController *)vc didFinishLoginWithCredentials:(NSDictionary *)credentials
{
    NSLog(@"Login is finished somehow");
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", credentials);
}

@end
