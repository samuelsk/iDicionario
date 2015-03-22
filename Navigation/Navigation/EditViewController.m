//
//  EditViewController.m
//  Navigation
//
//  Created by Samuel Shin Kim on 20/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "EditViewController.h"
#import "SearchViewController.h"
#import "LetraViewController.h"
#import "iDicionarioManager.h"

@interface EditViewController () {
    UITextField *palavra;
    UIImageView *imagem;
    UIDatePicker *dataModif;
}

@end


#pragma mark - Interface

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [self setTitle:[[iDicionario.items objectAtIndex:iDicionario.letterIndex] letra]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = done;
    
    palavra = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    [palavra setText:[[iDicionario.items objectAtIndex:iDicionario.letterIndex] palavra]];
    [palavra setDelegate:self];
    [self.view addSubview:palavra];
    
    imagem = [[UIImageView alloc] init];
    [imagem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [[iDicionario.items objectAtIndex:iDicionario.letterIndex] imagem]]]];
    [imagem sizeToFit];
    [imagem setCenter:self.view.center];
    [imagem setUserInteractionEnabled:YES];
    [self.view addSubview:imagem];
    
    dataModif = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 340, 0, 0)];
    [dataModif setDatePickerMode:UIDatePickerModeDate];
    //Não é necessário realizar uma ação toda a vez que o usuário girar a rodinha, apenas quando ele finalizar a edição.
//    [dataModif addTarget:self action:@selector(dataSelec) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:dataModif];
    
    [self addGestureRecognizers];
}

- (void)addGestureRecognizers {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editarImagem:)];
    [tap setDelegate:self];
    [imagem addGestureRecognizer:tap];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)editarImagem:(id)sender {
    NSLog(@"Editar Imagem");
    
}

- (void)done:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [[iDicionario.items objectAtIndex:iDicionario.letterIndex] setPalavra:palavra.text];
    [[iDicionario.items objectAtIndex:iDicionario.letterIndex] setDataModif:[dataModif date]];
    
    //Corretamente atribui o vetor de view controllers na navigation controller dependendo da root view.
    if ([self.navigationController.viewControllers.firstObject isMemberOfClass:[SearchViewController class]]) {
        [self.navigationController setViewControllers:@[[[SearchViewController alloc] init], [[LetraViewController alloc] init], self]];
    } else {
        [self.navigationController setViewControllers:@[[[LetraViewController alloc] init], self] animated:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
