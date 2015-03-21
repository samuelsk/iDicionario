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
    if ([self.navigationController.viewControllers.firstObject isMemberOfClass:[SearchViewController class]]) {
        [self.navigationController setViewControllers:@[[[SearchViewController alloc] init], [[LetraViewController alloc] init], self]];
    } else {
        [self.navigationController setViewControllers:@[[[LetraViewController alloc] init], self] animated:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
