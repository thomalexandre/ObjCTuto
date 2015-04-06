//
//  Person.m
//  FirstApp
//
//  Created by Alexandre THOMAS on 30/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)init
{
    return [self initWithName:@"John" age:40];
}

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name age:40];
}

- (instancetype)initWithName:(NSString *)name age:(int)age
{
    self = [super init];
    if (self != nil) {
        _name = name;
        _age = age;
    }
    return self;
}

- (void)walk
{
    NSLog(@"Walking");
}

- (NSNumber *)speed
{
    return @230.5; //@ to convert a int/double ... into a NSNumber
}

- (void)singSong:(NSString *)title
{
    NSLog(@"%@", title);
}

- (void)singSong:(NSString *)title multipleTime:(int)times
{
    for(int i = 0; i < times; i++) {
        [self singSong:title];
    }
}

//@synthesize  name = _name;
//@synthesize age = _age;


/*- (NSString*)name
{
    return _name;
}

- (void) setName:(NSString *) name
{
    _name = name;
}

- (int)age
{
    return _age;
}

- (void)setAge:(int)age
{
    _age = age;
}*/
@end
