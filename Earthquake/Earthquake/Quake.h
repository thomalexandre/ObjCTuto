//
//  Quake.h
//  Earthquake
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Quake : NSManagedObject

@property (nonatomic, retain) NSString * quakeTitle;
@property (nonatomic, retain) NSNumber * quakeMagnitude;
@property (nonatomic, retain) NSString * quakeLocation;
@property (nonatomic, retain) NSDate * quakeDate;
@property (nonatomic, retain) NSNumber * quakeDepth;
@property (nonatomic, retain) Location *location;

@end
