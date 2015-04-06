//
//  ThirdViewController.m
//  TabBar
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)displayValue {
    
    [self.textField3 resignFirstResponder];
    
    [self manageArray];
    [self manageSet];
    [self manageDictionary];
}


- (void)manageArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array insertObject:self.textField1.text atIndex:array.count];
    [array insertObject:self.textField2.text atIndex:array.count];
    [array insertObject:self.textField3.text atIndex:array.count];
    
    for(int i = 0; i< array.count; i++) {
        NSLog(@"%@", array[i]);
    }
}


- (void)manageSet
{
    NSMutableSet *set = [[NSMutableSet alloc] init];
    [set addObject:self.textField1.text];
    [set addObject:self.textField2.text];
    [set addObject:self.textField3.text];
    
    
    
}

- (void)manageDictionary
{
    NSMutableDictionary *dictionarry = [[NSMutableDictionary alloc] init];
    
    
    
}


@end
