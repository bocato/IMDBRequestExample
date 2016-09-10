//
//  ViewController.m
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 09/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import "ViewController.h"
#import "ApiManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *movieNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *findDataButton;
@property (weak, nonatomic) IBOutlet UITextView *dataTextView;
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

- (IBAction)findDataAction:(id)sender {
    [_movieNameTextField resignFirstResponder]; // Hides the keyboard
    
    self.dataTextView.text = @"Downloading movie info...";
    [[ApiManager sharedManager] getMovieWithName:self.movieNameTextField.text ?: @"" success:^(Movie *response) {
        
        self.movieFromSearchResult = response;
        self.dataTextView.text = @"Movie Info Donwloaded!\n\nClick on *Show Data* to see the result.";
        
    } failure:^(NSError *error) {
        self.dataTextView.text = [NSString stringWithFormat:@"Error!\n %@", error.description];
    }];
    
}

- (IBAction)showDataAction:(id)sender {
    [_movieNameTextField resignFirstResponder]; // Hides the keyboard
    if(self.movieFromSearchResult){
        NSString *text = [@"Title: " stringByAppendingString:self.movieFromSearchResult.title];
        text = [[text stringByAppendingString:@"\nYear: "] stringByAppendingString:self.movieFromSearchResult.year];
        text = [[text stringByAppendingString:@"\nRuntime: "] stringByAppendingString:self.movieFromSearchResult.runtime];
        // bla bla bla
        
        self.dataTextView.text = text;
    }
}

@end
