//
//  CustomCell.m
//  BexApp
//
//  Created by Timotheus Jochum on 23/02/16.
//  Copyright © 2016 Timotheus Jochum. All rights reserved.
//

#import "CustomCell.h"
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]
@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor greenColor]]; // set color here
    [self setSelectedBackgroundView:selectedBackgroundView];
}

@end
