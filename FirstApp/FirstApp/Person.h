//
//  Person.h
//  FirstApp
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    //NSString *_name;
    //int _age;
}

- (instancetype)initWithName:(NSString *) name age:(int)age NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithName:(NSString *) name;

//@property (strong, readonly, atomic, setter = setMyName:, getter=myName) NSString *name;
@property (copy, nonatomic) NSString *name;
@property (assign, readwrite, nonatomic) int age;
// strong pointer is by default, weak just point to it witout retaining, like in remion class image smart pointer (only for object)
// assigned only for primitives int, double, char....
// readwrite is de fault
// atomic: blocking the thrad until the function is completed --> default
// nonatomic: better to use nonatomic for performance
// copy: create a copy of the object when passing to the setter. Issue with mutable


/*- (NSString*)name;
- (void) setName:(NSString *) name;

- (int)age;
- (void)setAge:(int)age;*/


- (void)walk;
- (NSNumber *)speed;
- (void)singSong:(NSString *)title;
- (void)singSong:(NSString *)title multipleTime:(int)times;


@end
