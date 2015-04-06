//
//  QuakeWeb.h
//  Earthquake
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface QuakeWeb : NSManagedObject

@property (nonatomic, retain) NSString * quakeURL;
@property (nonatomic, retain) Location *location;

@end
