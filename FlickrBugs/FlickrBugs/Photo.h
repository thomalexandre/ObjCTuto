//
//  Photo.h
//  FlickrBugs
//
//  Created by Geppy Parziale on 10/21/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Photo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSURL *thumbanailUrl;
@property (nonatomic, copy) NSURL *fullImageUrl;
@property (nonatomic, copy) NSURL *locationUrl;

@property (nonatomic) long long photoID;
@property (nonatomic) NSInteger farm;
@property (nonatomic) NSInteger server;
@property (nonatomic, copy) NSString *secret;

@end
