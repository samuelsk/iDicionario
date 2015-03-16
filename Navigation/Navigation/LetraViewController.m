//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraViewController.h"
#import "SearchViewController.h"
#import "iDicionarioManager.h"
#import "ItemDicionario.h"

@implementation LetraViewController


-(void) viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setDelegate:self];
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [self setTitle:[[iDicionario.items objectAtIndex:iDicionario.pageCount] letra]];
    
    //Verifica se já foram adicionadas 26 views na navigation controller para remover o ícone de próximo
    NSLog(@"%d", iDicionario.pageCount);
    if (iDicionario.pageCount < 25) {
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem = next;
    }
    
    //Verifica se a view anterior faz parte da classe SearchViewController para inserir um ícone diferente
    if ([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2] isMemberOfClass:[SearchViewController class]]) {
        UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(previous:)];
        self.navigationItem.leftBarButtonItem = previous;
    } else {
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(previous:)];
    self.navigationItem.leftBarButtonItem = previous;
    }
    
    UILabel *palavra = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    [palavra setText:[[iDicionario.items objectAtIndex:iDicionario.pageCount] palavra]];
    [self.view addSubview:palavra];
    
    UIButton *botao = [UIButton buttonWithType:UIButtonTypeSystem];
//    [botao setTitle:@"Mostre uma palavra, uma figura e leia a palavra ao apertar um botao" forState:UIControlStateNormal];
    [botao setTitle:@"Exibir" forState:UIControlStateNormal];
    [botao sizeToFit];
    botao.center = self.view.center;
    
    [self.view addSubview:botao];
}

- (void)previous:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    iDicionario.pageCount--;
    [self.navigationController setDelegate:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    iDicionario.pageCount++;
    LetraViewController *proximo = [[LetraViewController alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:proximo animated:YES];
}


@end
