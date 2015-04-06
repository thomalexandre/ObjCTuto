//
//  ViewController.h
//  Earthquake
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreData;

@interface ViewController : UIViewController

// We use globalMoc because it will be created on the main queue
@property (nonatomic, strong) NSManagedObjectContext *globalMoc;

- (IBAction) updateDate;

@end

