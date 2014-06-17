//
//  GGZMovieViewCell.m
//  RottenTomatoes
//
//  Created by Guozheng Ge on 6/7/14.
//  Copyright (c) 2014 gzge. All rights reserved.
//

#import "GGZMovieViewCell.h"

@implementation GGZMovieViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    // see iOS 7 colors: http://3200goodies.com/wp-content/uploads/2013/09/ios-7-rgb-color-values1.jpg
    
    // set background color when selected
    UIView *cellSelectedBackgroundView = [[UIView alloc] init];
    cellSelectedBackgroundView.backgroundColor = [UIColor colorWithRed:(255/255.0) green:(204/255.0) blue:(0/255.0) alpha:0.8];
    self.selectedBackgroundView = cellSelectedBackgroundView;
    
    self.backgroundColor = [UIColor clearColor];
}

@end
