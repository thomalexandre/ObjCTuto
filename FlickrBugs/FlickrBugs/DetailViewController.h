//
//  DetailViewController.h
//  FlickrBugs
//
//  Created by Geppy Parziale on 10/21/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSURL *imageUrl;
@end
