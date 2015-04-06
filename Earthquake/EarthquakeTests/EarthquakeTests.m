//
//  EarthquakeTests.m
//  EarthquakeTests
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface EarthquakeTests : XCTestCase

@property (nonatomic) ViewController *vc;
@end

@implementation EarthquakeTests


// call once at the begining o the class
+ (void)setUp
{
    
}


// called before each single test
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void) testDataUpdate
{
    XCTAssertNotNil(self.vc, @"The view controller is nil");
    
    [self.vc  updateDate];
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
