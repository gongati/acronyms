//
//  ResultsTableViewController.m
//  FetchAcronyms
//
//  Copyright © 2017 Vishnu Reddy. All rights reserved.
//

#import "ResultsTableViewController.h"
#import <MBProgressHUD.h>
#import <AFNetworking.h>

@interface ResultsTableViewController ()

@property (nonatomic) NSMutableArray *resultsList;

@end

@implementation ResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchDataForAcronym:self.currentAcronym];
    self.title = self.currentAcronym;
}

- (void)fetchDataForAcronym:(NSString*)acronym {
    NSString *urlString = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@",acronym];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [self showLoadingOverlay];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray* responseArray = [NSArray arrayWithArray:responseObject];
        NSArray* longformsArray;
        if (responseArray.count > 0) {
           longformsArray = [NSArray arrayWithArray:[[responseArray objectAtIndex:0] valueForKey:@"lfs"]];
        }else{
            longformsArray = [NSArray array];
        }
        
        self.resultsList = [[NSMutableArray alloc] init];
        
        for (NSDictionary* listDictionary in longformsArray) {
            [self.resultsList addObject:[listDictionary valueForKey:@"lf"]];
        }
        [self hideLoadingOverlay];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self hideLoadingOverlay];
        
        UIAlertController *alertView = [UIAlertController  alertControllerWithTitle:@"Error Retrieving data" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { }];
        [alertView addAction:okAction];
        [self presentViewController:alertView animated:YES completion:nil];
        
    }];
    
    [operation start];
}

-(void)showLoadingOverlay {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideLoadingOverlay {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.resultsList objectAtIndex:indexPath.row];
    
    return cell;
}

@end
