//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraViewController.h"
#import "SearchViewController.h"
#import "EditViewController.h"
#import "iDicionarioManager.h"
#import "ItemDicionario.h"

@implementation LetraViewController {
    UILabel *palavra;
    UIImageView *imagem;
    UILabel *dataModif;
}


#pragma mark - Interface

-(void) viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setDelegate:self];
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [self setTitle:[[iDicionario.items objectAtIndex:iDicionario.letterIndex] letra]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //Verifica se a root view faz parte da classe SearchViewController para inserir um ícone diferente
    if ([self.navigationController.viewControllers.firstObject isMemberOfClass:[SearchViewController class]]) {
        UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(previous:)];
        self.navigationItem.leftBarButtonItem = previous;
    } else {
        UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(previous:)];
        self.navigationItem.leftBarButtonItem = previous;
        
        UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
        self.navigationItem.rightBarButtonItem = next;
    }
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 64, 320, 35)];
    [self.toolBar setItems:@[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit:)]]];
    [self.view addSubview:self.toolBar];
    
    palavra = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 0, 0)];
    [palavra setText:[[iDicionario.items objectAtIndex:iDicionario.letterIndex] palavra]];
    [palavra setTextAlignment:NSTextAlignmentCenter];
    [palavra sizeToFit];
    [self.view addSubview:palavra];
    
    imagem = [[UIImageView alloc] initWithImage:[[iDicionario.items objectAtIndex:iDicionario.letterIndex] getDataImage]];
    [imagem setFrame:CGRectMake(0, 0, 150, 150)];
    [imagem setCenter:self.view.center];
    [imagem.layer setCornerRadius:imagem.frame.size.width/2];
    [imagem.layer setBorderWidth:0.5];
    [imagem.layer setMasksToBounds:YES];
    [imagem setUserInteractionEnabled:YES];
    
    dataModif = [[UILabel alloc] initWithFrame:CGRectMake(110, 450, 0, 0)];
    [dataModif setText:[[[[iDicionario.items objectAtIndex:iDicionario.letterIndex] dataModif] description] substringToIndex:10]];
    [dataModif sizeToFit];
    [self.view addSubview:dataModif];
    
    [self addGestureRecognizers];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [imagem setAlpha:1.0];
    [imagem setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    [self.view addSubview:imagem];
    [UIView animateWithDuration:1 animations:^{
        [imagem setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    }];
}

- (void)addGestureRecognizers {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(translacaoImagem:)];
    [longPress setDelegate:self];
    [longPress setMinimumPressDuration:0.2];
    [imagem addGestureRecognizer:longPress];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImagem:)];
    [pinch setDelegate:self];
    [self.view addGestureRecognizer:pinch];
    //    [imagem addGestureRecognizer:pinch];
    
    if (![self.navigationController.viewControllers.firstObject isMemberOfClass:[SearchViewController class]]) {
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [swipeLeft setDelegate:self];
        [self.view addGestureRecognizer:swipeLeft];
    }
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previous:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeRight setDelegate:self];
    [self.view addGestureRecognizer:swipeRight];
}


#pragma mark - Animações

- (void)zoomImagem:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:1 animations:^{
            [imagem setTransform:CGAffineTransformScale(imagem.transform, 1.4, 1.4)];
        }];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:1 animations:^{
            [imagem setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
        }];
    }
}

- (void)translacaoImagem:(UIGestureRecognizer *)sender {
    [UIView animateWithDuration:0.1 animations:^{
//        [imagem setTransform:CGAffineTransformMakeTranslation([sender locationInView:self.view].x-imagem.center.x, [sender locationInView:self.view].y-imagem.center.y)];
        [imagem setCenter:[sender locationOfTouch:0 inView:self.view]];
    }];
}


#pragma mark - Navegação

- (void)previous:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    if (iDicionario.letterIndex == 0)
        iDicionario.letterIndex = 25;
    else
        iDicionario.letterIndex--;
    [self.navigationController setDelegate:nil];
    if (self.navigationController.viewControllers.count == 1)
        [self.navigationController setViewControllers:@[[[LetraViewController alloc] init], self] animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    if (iDicionario.letterIndex == 25)
        iDicionario.letterIndex = 0;
    else
        iDicionario.letterIndex++;
    if (self.navigationController.viewControllers.count == 2)
        [self.navigationController setViewControllers:@[self] animated:YES];
    
    [UIView animateWithDuration:1 animations:^{
        [imagem setTransform:CGAffineTransformScale(imagem.transform, 0.0, 0.0)];
    }];
    [self.navigationController pushViewController:[[LetraViewController alloc] init] animated:YES];
}

- (void)edit:(id)sender {
    [self.navigationController pushViewController:[[EditViewController alloc] init] animated:YES];
}


@end
