//
//  Animator.h
//  CustomTransition
//
//  Created by Alexandre THOMAS on 01/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype) initWithOperation:(UINavigationControllerOperation)operation NS_DESIGNATED_INITIALIZER;

@end
