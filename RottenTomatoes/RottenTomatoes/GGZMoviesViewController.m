//
//  GGZMoviesViewController.m
//  RottenTomatoes
//
//  Created by Guozheng Ge on 6/7/14.
//  Copyright (c) 2014 gzge. All rights reserved.
//

#import "GGZMoviesViewController.h"
#import "GGZMovieViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "GGZMovieDetailViewController.h"
#import "MBProgressHUD.h"

@interface GGZMoviesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) UIRefreshControl *refresh;

@end

@implementation GGZMoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Top Box Office";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 130;
    
    [self bindData]; // first time load
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GGZMovieViewCell" bundle:nil] forCellReuseIdentifier:@"GGZMovieViewCell"];
    
    // pull to refresh and load again
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [self.refresh addTarget:self action:@selector(bindData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refresh];
    [self bindData];
    
}

- (void)bindData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading...";
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Get top 10 box office from Rotten Tomatoes
        NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=6psypq3q5u3wf9f2be38t5fd&limit=10";
        NSLog(@"getting movie list from Rotten Tomatoes, REST API call url: %@", url);
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", object);
            
            [hud hide:YES];
            
            self.movies = object[@"movies"];
            [self.tableView reloadData];
        }];
        
        if (self.refresh != nil && self.refresh.isRefreshing == YES) {
            [self.refresh endRefreshing];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell for row %d", indexPath.row);
    
    GGZMovieViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GGZMovieViewCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    NSString *imageURLString = movie[@"posters"][@"profile"];
    NSLog(@"post image url: %@", imageURLString);
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    __weak GGZMovieViewCell *weakCell = cell;
    
    [cell.posterImageView setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.posterImageView.image = image;
                                       [weakCell setNeedsLayout];
                                   }
                                         failure:nil];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"showing details for row %d", indexPath.row);
    
    GGZMovieDetailViewController *detailvc = [[GGZMovieDetailViewController alloc] init];
    
    // pass the movie image URL, title and synopsis to the detail view controller
    NSDictionary *movie = self.movies[indexPath.row];
    NSString *imageURLString = movie[@"posters"][@"original"];
    detailvc.imageURLString = imageURLString;
    detailvc.movieTitle = movie[@"title"];
    detailvc.movieSynopsis = movie[@"synopsis"];
    NSLog(@"passing image URL: %@ to detail view controller", imageURLString);
    
    // customize the navigation bar
    // set back button text to Movies
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Movies" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    // set title to the movie title
    detailvc.navigationItem.title = movie[@"title"];
    
    // push a view controller with navigation controller
    [self.navigationController pushViewController:detailvc animated:YES];
}

@end
