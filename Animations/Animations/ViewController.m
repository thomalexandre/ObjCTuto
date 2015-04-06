//
//  ViewController.m
//  Animations
//
//  Created by Alexandre THOMAS on 01/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer *redLayer;
@property (nonatomic, weak) IBOutlet UIView *redView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topConstraint;
@property (nonatomic) UIDynamicAnimator *animator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/800.0;
    self.view.layer.sublayerTransform = identity;
    
    self.redLayer = [CALayer layer]; // class methond, used as constructor, like alloc init
    self.redLayer.bounds = CGRectMake(0, 0, 100, 100);
    self.redLayer.position = CGPointMake(120, 140);
    self.redLayer.backgroundColor = [[UIColor redColor] CGColor];   //need to convert uicolor to core graphic color not the ui kit version
    
    self.redLayer.borderColor = [[UIColor blueColor] CGColor];
    self.redLayer.borderWidth = 4.0;
    self.redLayer.cornerRadius = 12.0;
    
    self.redLayer.shadowColor = [[UIColor blackColor] CGColor];
    self.redLayer.shadowOffset = CGSizeMake(0.0, 4.0);
    self.redLayer.shadowOpacity = 0.8;
    self.redLayer.shadowRadius = 6.0;
    
    self.redLayer.transform = CATransform3DMakeRotation(45 * M_PI / 180.0, 0, 1, 0);
    
    [self.view.layer addSublayer:self.redLayer];
    
    /// FOR THE GRAVITY, collision, stuff.....
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    
}


- (IBAction)startAnimation
{
    // Intrinsinc or implicit animation
    //[self implicitAnimation];
    
    
    // Explicit animation
    [self explicitAnimation];
    
    //Severla animations one after the other
    //[self severalAnimation];
    
    // animate uiview
    //[self animationWithUIVIew];
    
    // gravity
    [self animateWithGravity];
}

- (void) implicitAnimation
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setDisableActions:YES]; // used to disable animation
    self.redLayer.bounds = CGRectMake(0, 0, 200, 200);
    self.redLayer.backgroundColor = [[UIColor greenColor] CGColor];
    self.redLayer.transform = CATransform3DMakeRotation(0 * M_PI / 180.0, 0, 1, 0);
    self.redLayer.cornerRadius = 50.0;
    self.redLayer.position = CGPointMake(180, 440);
    [CATransaction commit];
}

- (void) explicitAnimation
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    basicAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
    basicAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 180, 440)];
    basicAnimation.duration = 1.5;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //basicAnimation.autoreverses = YES;
    //basicAnimation.repeatCount = HUGE_VALF;
    
    self.redLayer.bounds = CGRectMake(0, 0, 180, 440);
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.redLayer addAnimation:basicAnimation forKey:nil];
    [CATransaction begin];
}

- (void) severalAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(120, 140)],
                         [NSValue valueWithCGPoint:CGPointMake(120, 340)],
                         [NSValue valueWithCGPoint:CGPointMake(280, 340)],
                         [NSValue valueWithCGPoint:CGPointMake(120, 140)]];
    
    animation.keyTimes = @[ @(0), @(0.3), @(0.8), @(1.0) ];
    animation.duration = 2.0;
    
    [self.redLayer addAnimation:animation forKey:nil];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.redLayer.position = CGPointMake(120, 140);
    [CATransaction begin];
}

- (void) animationWithUIVIew
{
    
    self.topConstraint.constant = 200;
    
//    [UIView animateWithDuration:1.2 animations:^{
//        // WE ARE NOT ALLOWED TO MOVE THE CONTENT OF THE FRAME, INSTEAD IS TO  PLAY WITH THE CONSTRAINT
//        //self.redView.frame = CGRectMake(160, 300, self.redView.frame.size.width, self.redView.frame.size.height);
//        
//        [self.redView layoutIfNeeded];
//        self.redView.backgroundColor = [UIColor blueColor];
//    }];
    
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10.0 options:0 animations:^{
        [self.redView layoutIfNeeded];
        self.redView.backgroundColor = [UIColor blueColor];
    }completion:nil];
    
}

- (void) animateWithGravity
{
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.redView]];
    //gravity.gravityDirection = CGVectorMake(<#CGFloat dx#>, <#CGFloat dy#>);

    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.redView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    UIDynamicItemBehavior *itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.redView]];
    itemBehaviour.elasticity = 0.7;
    
    [self.animator addBehavior:itemBehaviour];
    [self.animator addBehavior:collision];
    [self.animator addBehavior:gravity];
    
    // Dont set the animator to nil to stop tthe animation!!!!
}


@end
