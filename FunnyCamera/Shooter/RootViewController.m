//
//  RootViewController.m
//  FunnyCamera
//
//  Created by Geppy Parziale on 10/19/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController () <ViewControllerDelegate>

@end

@implementation RootViewController

- (IBAction)launchCamera:(id)sender
{
    ViewController *vc = [[ViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didFinishViewController:(ViewController *)vc
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
