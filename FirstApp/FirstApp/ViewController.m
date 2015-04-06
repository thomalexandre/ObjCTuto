//
//  ViewController.m
//  FirstApp
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Person *person = [Person alloc];
    //person = [person init]; or more common use the below way of allocating the object
    Person *person = [[Person alloc] initWithName:@"Alex" age:35];
    
    /*[person setAge:55];
    person.age = 55; //same as above because it is a variable propertiz
    
    [person setName:@"Aurele"];
    person.name = @"aurele";
    
    NSString *name = [person name];
    
    NSLog(@"%@", person);
    [person walk];
    [person singSong:@"Title" multipleTime:4];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sayHello
{
    self.label.text = @"Hello";
    [[self label] setText:@"Hello"];
    [self.label setText:@"Hello"];
    
}

@end
