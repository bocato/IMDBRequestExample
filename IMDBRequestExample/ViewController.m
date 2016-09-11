//
//  ViewController.m
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 09/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import "ViewController.h"
#import "ApiManager.h"
#import "MBProgressHUDHelper.h"

@interface ViewController ()

#pragma mark - View Elements
@property (weak, nonatomic) IBOutlet UITextField *movieNameTextField;
@property (weak, nonatomic) IBOutlet UIView *movieInfoView;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

// movie info items
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;

#pragma mark - Class Elements
@property (strong, nonatomic) Movie *movieFromSearchResult;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
- (IBAction)findDataAction:(id)sender {
    [_movieNameTextField resignFirstResponder]; // Hides the keyboard
    
    [MBProgressHUDHelper showMBProgressInView:self.view withAnimationType:MBProgressHUDModeIndeterminate withTitle:@"Downloading movie info..."];
    [[ApiManager sharedManager] getMovieWithName:self.movieNameTextField.text ?: @"" success:^(Movie *response) {
        
        self.movieFromSearchResult = response;
        [self showDataOnView];
        
    } failure:^(NSError *error) {
        NSString *errorMessage = [NSString stringWithFormat:@"Error!\n %@", error.description];
        [self showErrorMessage:errorMessage];
    }];
    
}

#pragma mark - Data Loading
- (void)hideResultsView{
    [self.movieInfoView setHidden:YES];
    [self.resultsLabel setHidden:YES];
}

- (void)showResultsView{
    [self.movieInfoView setHidden:NO];
    [self.resultsLabel setHidden:NO];
    [self.movieInfoView setNeedsLayout];
}

- (void)loadViewImageView:(UIImageView *)imageView fromUrlString:(NSString *)urlString{
    
    NSString *urlStringHttps = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURL *imgURL = [NSURL URLWithString:urlStringHttps];
    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
    imageView.image = [UIImage imageWithData:imgData];
    
    [imageView setNeedsLayout];
}

- (void)showDataOnView{
    if(self.movieFromSearchResult.title.length > 0){
        
        [self loadViewImageView:self.movieImage fromUrlString:self.movieFromSearchResult.poster];
        self.titleLabel.text = self.movieFromSearchResult.title;
        self.yearLabel.text = self.movieFromSearchResult.year;
        self.runtimeLabel.text = self.movieFromSearchResult.runtime;
        
        [self showResultsView];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else{
        [self showErrorMessage:@"No movie was found.\n =("];
    }
}

- (void)showErrorMessage:(NSString *)errorMessage{
    [self hideResultsView];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                    message:errorMessage
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
