//
//  GGZMovieViewCell.h
//  RottenTomatoes
//
//  Created by Guozheng Ge on 6/7/14.
//  Copyright (c) 2014 gzge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGZMovieViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end
