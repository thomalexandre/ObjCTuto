//
//  ViewController.h
//  Shooter
//
//  Created by Geppy Parziale on 2/24/12.
//  Copyright (c) 2012 iNVASIVECODE, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMedia/CoreMedia.h>
#import <Accelerate/Accelerate.h>
#import <AVFoundation/AVFoundation.h>

@protocol ViewControllerDelegate;


@interface ViewController : UIViewController
@property (nonatomic, weak) id<ViewControllerDelegate> delegate;
- (IBAction)doneWithCamera:(id)sender;
@end


@protocol ViewControllerDelegate <NSObject>
- (void)didFinishViewController:(ViewController *)vc;
@end