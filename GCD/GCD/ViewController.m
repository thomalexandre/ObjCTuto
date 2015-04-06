//
//  ViewController.m
//  GCD
//
//  Created by Alexandre THOMAS on 01/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.kinja.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
       
        for(int i=0;i<100;i++) {
            NSLog(@"Block 1: %d",i);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view.backgroundColor = [UIColor redColor];
        });
    });
    
    dispatch_async(queue, ^{
        
        for(int i=0;i<10;i++) {
            NSLog(@"Block 2: %d",i);
        }
        
    });
    
    NSLog(@"Done");
    
}

@end
