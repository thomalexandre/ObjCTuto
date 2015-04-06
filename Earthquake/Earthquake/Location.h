//
//  Location.h
//  Earthquake
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Quake, QuakeWeb;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * quakeLongitude;
@property (nonatomic, retain) NSNumber * quakeLatitute;
@property (nonatomic, retain) Quake *quake;
@property (nonatomic, retain) QuakeWeb *quakeWeb;

@end
