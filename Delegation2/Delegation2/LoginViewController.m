//
//  LoginViewController.m
//  Delegation2
//
//  Created by Alexandre THOMAS on 31/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneLogin
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(loginViewController:didFinishLoginWithCredentials:)] ) {
        
        NSMutableDictionary *credentials = [[NSMutableDictionary alloc] init];
        [credentials setObject:@"Alexandre Thomas" forKey:@"login"];
        [credentials setObject:@"1234" forKey:@"password"];
        
        NSLog(@"DONE");
        
        //[self.delegate loginViewController:self didFinishLoginWithCredentials:credentials];
        
        [self.delegate loginViewController:self didFinishLoginWithCredentials:@{@"alex":@"Alexandre Thomas", @"password":@"1234"}];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
