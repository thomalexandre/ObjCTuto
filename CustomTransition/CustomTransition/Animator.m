//
//  Animator.m
//  CustomTransition
//
//  Created by Alexandre THOMAS on 01/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "Animator.h"

#define kDamping    0.5
#define kVelocity   10.0
#define kScale      0.9

@implementation Animator
{
    UINavigationControllerOperation _operation; //WE can do like this because it is a simple type, it is not an object. If we have an object, let's create a property
}

- (instancetype) initWithOperation:(UINavigationControllerOperation)operation
{
    self = [super init];
    if(self) {
        _operation = operation;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8;
}

// write the animation here
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView]; // view where the transition happen
    containerView.backgroundColor = [UIColor whiteColor];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    NSTimeInterval halfDuration = [self transitionDuration:transitionContext] / 2;
    
    
    
    
    
    void(^blk)(BOOL finished) = ^(BOOL finished) {
        if(finished){
            //to tell the animator that is it completed
            [transitionContext completeTransition:YES];
        }
    };

    
    if (_operation == UINavigationControllerOperationPush) {
    
        [UIView animateWithDuration:halfDuration
                              delay:0
             usingSpringWithDamping:kDamping
              initialSpringVelocity:kVelocity
                            options:0 animations:^{
                                
                                fromView.transform = CGAffineTransformMakeScale(kScale, kScale);
                                
                            }completion:^(BOOL finished){
                                if(finished) {
                                    toView.frame = CGRectMake(containerView.frame.size.width, 0, containerView.frame.size.width, containerView.frame.size.height);
                                    [containerView addSubview:toView];
                                    
                                    
                                    [UIView animateWithDuration:halfDuration
                                                          delay:0
                                         usingSpringWithDamping:kDamping
                                          initialSpringVelocity:kVelocity
                                                        options:0
                                                     animations:^{
                                        toView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
                                     
                                     }completion:^(BOOL finished) {
                                         if(finished){
                                             //to tell the animator that is it completed
                                             fromView.transform = CGAffineTransformIdentity;
                                             [transitionContext completeTransition:YES];
                                         }
                                     }];
                                    
                                }
                            }];
    
    }
    else if (_operation == UINavigationControllerOperationPop) {
    
        // display the to View to display
        [containerView insertSubview:toView belowSubview:fromView];
        toView.transform = CGAffineTransformMakeScale(kScale, kScale);
        
        
        [UIView animateWithDuration:halfDuration
                              delay:0
             usingSpringWithDamping:kDamping
              initialSpringVelocity:kVelocity
                            options:0
                         animations:^{
                             fromView.frame = CGRectMake(containerView.frame.size.width, 0, containerView.frame.size.width, containerView.frame.size.height);
                         } completion:^(BOOL finished) {
                             if(finished){
                                 [UIView animateWithDuration:halfDuration
                                                       delay:0
                                      usingSpringWithDamping:kDamping
                                       initialSpringVelocity:kVelocity
                                                     options:0
                                                  animations:^{
                                                      toView.transform = CGAffineTransformIdentity;
                                                  } completion:blk];
                             }
                         }];
        
    }
    
}

@end
