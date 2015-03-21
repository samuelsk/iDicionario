//
//  SearchViewController.m
//  Navigation
//
//  Created by Samuel Shin Kim on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "SearchViewController.h"
#import "LetraViewController.h"
#import "iDicionarioManager.h"

@interface SearchViewController ()

@end

@implementation SearchViewController


#pragma mark - Interface

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Busca"];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 35)];
    [self.searchBar setBackgroundColor:[UIColor blackColor]];
    [self.searchBar setDelegate:self];
    [self.searchBar setPlaceholder:@"Buscar"];
    [self.searchBar setShowsCancelButton:YES];
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 310, 420)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView
     ];
    
}

- (void)shake {
    
}


#pragma mark - Search Bar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    int letterIndex = [iDicionario buscaPalavra:searchBar.text];
    if (letterIndex == -1)
        [self shake];
    else {
        [iDicionario setLetterIndex:letterIndex];
        [self.navigationController pushViewController:[[LetraViewController alloc] init] animated:YES];
    }
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    return iDicionario.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [[iDicionario.items objectAtIndex:indexPath.row] palavra]]];
    return cell;
}


#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [iDicionario setLetterIndex:(int)indexPath.row];
    [self.navigationController pushViewController:[[LetraViewController alloc] init] animated:YES];
}

@end
