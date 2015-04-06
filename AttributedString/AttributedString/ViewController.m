//
//  ViewController.m
//  AttributedString
//
//  Created by Alexandre THOMAS on 03/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = NSLocalizedString(@"Hello", @"Title of the screen on the navigation controller"); // second argument is just a comment
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
