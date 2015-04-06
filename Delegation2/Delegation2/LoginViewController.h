//
//  LoginViewController.h
//  Delegation2
//
//  Created by Alexandre THOMAS on 31/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LoginViewControllerDelegate;

@interface LoginViewController : UIViewController
@property (nonatomic, weak) id<LoginViewControllerDelegate> delegate; //id is a pointer
@end


@protocol LoginViewControllerDelegate <NSObject>
// @optional  -->>>> to be optional, for all followed methods
- (void)loginViewController:(LoginViewController *)vc didFinishLoginWithCredentials:(NSDictionary *)credentials;
@end