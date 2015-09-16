//
//  ViewController.m
//  AuthorView
//
//  Created by Alexandre THOMAS on 26/06/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) NSArray *authors;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Create authors
    NSMutableArray *mutableAuthors = [[NSMutableArray alloc] init];
    [mutableAuthors addObject:@"avatar1"];
    [mutableAuthors addObject:@"avatar2"];
    [mutableAuthors addObject:@"avatar3"];
    self.authors = mutableAuthors;
    
    [self buildUI];
    
}

-(void)buildUI
{
    
    self.widthConstraint.constant = ([self.authors count] * 40) + 40;
    
    for(NSInteger i = [self.authors count] - 1; i >= 0; i--) {
        NSString *author = self.authors[i];
        UIImage *image = [UIImage imageNamed:author];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        imageView.layer.borderWidth = 5;
        imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        imageView.layer.cornerRadius = 40.0;
        imageView.layer.masksToBounds = YES;
        [self.container addSubview:imageView];
        [self setImageConstraints:imageView forIndex:i];
    }
}

-(void)setImageConstraints:(UIImageView *)imageView forIndex:(NSInteger)index {
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.container
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.container
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0.0]];
    
    CGFloat leftConstant = index * 40.0;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.container
                                                               attribute:NSLayoutAttributeLeft
                                                              multiplier:1.0
                                                                constant:leftConstant]];
    
    CGFloat rightConstant = (([self.authors count] - 1) - index) * 40.0;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                               attribute:NSLayoutAttributeRight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.container
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.0
                                                                constant:-rightConstant]];
    
    
    NSLog(@"%ld %f %f", (long)index, leftConstant, rightConstant);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
