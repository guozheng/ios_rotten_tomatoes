//
//  GGZMovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Guozheng Ge on 6/8/14.
//  Copyright (c) 2014 gzge. All rights reserved.
//

#import "GGZMovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface GGZMovieDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *infoView;

@end

@implementation GGZMovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // set image background
    NSLog(@"Got image url from previous view controller: %@", self.imageURLString);
    
    
    NSURL *imageURL = [NSURL URLWithString:self.imageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [self.movieImageView setImageWithURLRequest:request
                                placeholderImage:placeholderImage
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                             self.movieImageView.image = image;
                                         }
                                         failure:nil];
    
    self.titleLabel.text = self.movieTitle;
    self.synopsisLabel.text = self.movieSynopsis;
    
    [self.synopsisLabel sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
