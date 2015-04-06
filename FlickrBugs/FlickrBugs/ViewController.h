//
//  ViewController.h
//  FlickrBugs
//
//  Created by Geppy Parziale on 10/21/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

- (IBAction)updateData:(id)sender;

@end

