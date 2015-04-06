//
//  CustomCell.h
//  Earthquake
//
//  Created by Alexandre THOMAS on 02/04/15.
//  Copyright (c) 2015 Gawker Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelMagnitude;
@property (weak, nonatomic) IBOutlet UILabel *labelDepth;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;

@end
