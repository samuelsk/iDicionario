//
//  SearchViewController.m
//  Navigation
//
//  Created by Samuel Shin Kim on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "SearchViewController.h"
#import "LetraAViewController.h"
#import "iDicionarioManager.h"

@interface SearchViewController ()

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *dicionario = [[UIBarButtonItem alloc]
                             initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(openDicionario:)];
    self.navigationItem.rightBarButtonItem = dicionario;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 35)];
    [self.searchBar setBackgroundColor:[UIColor blackColor]];
    [self.searchBar setDelegate:self];
    [self.searchBar setPlaceholder:@"Buscar"];
    [self.searchBar setShowsCancelButton:YES];
    [self.view addSubview:self.searchBar];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - Navigation

-(void)openDicionario:(id)sender {
    LetraAViewController *letraViewController = [[LetraAViewController alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:letraViewController animated:NO];
}

@end
