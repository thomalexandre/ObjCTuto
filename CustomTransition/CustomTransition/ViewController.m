//
//  ViewController.m
//  CustomTransition
//
//  Created by Alexandre THOMAS on 01/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)next
{
    SecondViewController * svc = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self showViewController:svc sender:nil];
}

@end
