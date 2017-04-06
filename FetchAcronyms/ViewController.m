//
//  ViewController.m
//  FetchAcronyms
//
//  Copyright © 2017 Vishnu Reddy. All rights reserved.
//

#import "ViewController.h"
#import "ResultsTableViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    //Reset the text field
    self.inputData.text = @"";
}

-(IBAction)fetchDetails:(UIButton *)sender {
    //Don't go to next screen if the input is empty
    if (![self.inputData.text isEqualToString:@""]) {
        [self showDetails];
    }else{
        UIAlertController *alertView = [UIAlertController  alertControllerWithTitle:@"Error" message:@"Please enter some text..!!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
    }
}

- (void)showDetails {
    ResultsTableViewController *dvc = [[ResultsTableViewController alloc] init];
    dvc.currentAcronym = self.inputData.text;
    [self.navigationController pushViewController:dvc animated:YES];
}

@end
