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
    [self setTitle:@"Editar"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = done;
    
    palavra = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    [palavra setText:[[iDicionario.items objectAtIndex:iDicionario.letterIndex] palavra]];
    [palavra setDelegate:self];
    [self.view addSubview:palavra];
    
    imagem = [[UIImageView alloc] initWithImage:[[iDicionario.items objectAtIndex:iDicionario.letterIndex] imagem]];
    [imagem setFrame:CGRectMake(0, 0, 150, 150)];
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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Tirar foto", @"Escolher foto", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Tirar foto
    if (buttonIndex == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *noCameraAlert = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"Nenhuma câmera detectada" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [noCameraAlert show];
        } else
            [self tirarFoto];
        //Escolher foto
    } else if (buttonIndex == 1) {
        [self escolherFoto];
    }
}

- (void)tirarFoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setAllowsEditing:YES];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)escolherFoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setAllowsEditing:YES];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [imagem setImage:info[UIImagePickerControllerEditedImage]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

- (void)done:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [[iDicionario.items objectAtIndex:iDicionario.letterIndex] setPalavra:palavra.text];
    [[iDicionario.items objectAtIndex:iDicionario.letterIndex] setImagem:imagem.image];
    [[iDicionario.items objectAtIndex:iDicionario.letterIndex] setDataModif:[dataModif date]];
    
    //Atribui um vetor de view controllers na navigation controller com base na root view (i.e. se o usuário acessou a tela de edição pela SearchViewController ou pela LetraViewController).
    if ([self.navigationController.viewControllers.firstObject isMemberOfClass:[SearchViewController class]]) {
        [self.navigationController setViewControllers:@[[[SearchViewController alloc] init], [[LetraViewController alloc] init], self]];
    } else {
        [self.navigationController setViewControllers:@[[[LetraViewController alloc] init], self] animated:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
