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
    self.inputData.text = @"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"show details"])
    {
        ResultsTableViewController *rvc = [segue destinationViewController];
        rvc.currentAcronym = self.inputData.text;
    }
}

@end
