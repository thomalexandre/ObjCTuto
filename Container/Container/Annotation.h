//
//  Annotation.h
//  Container
//
//  Created by Alexandre THOMAS on 31/03/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

@import MapKit;

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
