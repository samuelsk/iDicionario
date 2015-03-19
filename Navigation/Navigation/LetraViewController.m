//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraViewController.h"
#import "iDicionarioManager.h"
#import "ItemDicionario.h"

@implementation LetraViewController {
    UILabel *palavra;
    UIImageView *imagem;
}


#pragma Interface

-(void) viewDidLoad {
//    [super viewDidLoad];
    [self.navigationController setDelegate:self];
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [self setTitle:[[iDicionario.items objectAtIndex:iDicionario.pageCount] letra]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSLog(@"%lu", self.navigationController.viewControllers.count);
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem = next;
    
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(previous:)];
    self.navigationItem.leftBarButtonItem = previous;
    
    //    //Verifica se a view anterior faz parte da classe SearchViewController para inserir um ícone diferente
    //    if ([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2] isMemberOfClass:[SearchViewController class]]) {
    //        UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(root:)];
    //        self.navigationItem.leftBarButtonItem = previous;
    //    } else {
    //    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(previous:)];
    //    self.navigationItem.leftBarButtonItem = previous;
    //    }
    
    palavra = [[UILabel alloc] init];
    [palavra setText:[[iDicionario.items objectAtIndex:iDicionario.pageCount] palavra]];
    [palavra setFrame:CGRectMake(100, 170, 0, 0)];
    [palavra setTextAlignment:NSTextAlignmentCenter];
    [palavra sizeToFit];
    [self.view addSubview:palavra];
    
    imagem = [[UIImageView alloc] init];
    [imagem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [[iDicionario.items objectAtIndex:iDicionario.pageCount] imagem]]]];
    [imagem sizeToFit];
    [imagem setCenter:self.view.center];
    [imagem setUserInteractionEnabled:YES];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(translacaoImagem:)];
    [longPress setDelegate:self];
    [longPress setMinimumPressDuration:0.2];
    [imagem addGestureRecognizer:longPress];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomImagem:)];
    [pinch setDelegate:self];
    [self.view addGestureRecognizer:pinch];
//    [imagem addGestureRecognizer:pinch];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeLeft setDelegate:self];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previous:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeRight setDelegate:self];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)viewDidAppear:(BOOL)animated {
    [palavra setAlpha:1.0];
    
    [imagem setAlpha:1.0];
    [imagem setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    [self.view addSubview:imagem];
    [UIView animateWithDuration:1 animations:^{
        [imagem setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
    }];
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
        [imagem setTransform:CGAffineTransformMakeTranslation([sender locationInView:self.view].x, [sender locationInView:self.view].y)];
    }];
}


#pragma mark - Navigation

- (void)previous:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    if (iDicionario.pageCount == 0)
        iDicionario.pageCount = 25;
    else
        iDicionario.pageCount--;
    [self.navigationController setDelegate:nil];
    if (self.navigationController.viewControllers.count == 1) {
        LetraViewController *anterior = [[LetraViewController alloc] initWithNibName:nil bundle:NULL];
        [self.navigationController setViewControllers:[NSArray arrayWithObjects:anterior, self, nil] animated:YES];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)next:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    if (iDicionario.pageCount == 25)
        iDicionario.pageCount = 0;
    else
        iDicionario.pageCount++;
    if (self.navigationController.viewControllers.count == 2)
        [self.navigationController setViewControllers:[NSArray arrayWithObject:self] animated:YES];
    LetraViewController *proximo = [[LetraViewController alloc] initWithNibName:nil bundle:NULL];
    
    [UIView animateWithDuration:1 animations:^{
        [imagem setTransform:CGAffineTransformScale(imagem.transform, 0.0, 0.0)];
    }];
    [palavra setAlpha:0.0];
    
    [self.navigationController pushViewController:proximo animated:YES];
}

//- (void)root:(id)sender {
//    [self.navigationController setDelegate:nil];
//    [self.navigationController popToRootViewControllerAnimated:NO];
//}


@end
