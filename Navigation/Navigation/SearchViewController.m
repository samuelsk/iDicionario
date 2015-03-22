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
    [self setTitle:@"Buscar"];
    
    //A largura da barra é 3px maior (total de 323px) devido a animação de shake.
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 323, 35)];
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
    //A animação move a barra de busca 3px para a esquerda e em seguida a retorna para a posição original repetidas vezes, simulando uma animação de shake.
    [UIView animateWithDuration:0.1 animations:^{
        //Número de vezes que a animação irá ser repetida.
        [UIView setAnimationRepeatCount:3];
        //Move a barra 3px para a esquerda.
        [self.searchBar setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, -3, 0)];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.1 animations:^{
                //Retorna a barra para a matriz de coordenadas original. Sem esse método, a animação só poderá acontecer uma vez.
                [self.searchBar setTransform:CGAffineTransformIdentity];
            }];
        }
    }];
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
