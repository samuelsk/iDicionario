//
//  LetrabViewController.m
//  Navigation
//
//  Created by Samuel Shin Kim on 17/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "LetraBViewController.h"
#import "LetraAViewController.h"
#import "LetraCViewController.h"
#import "iDicionarioManager.h"
#import "ItemDicionario.h"

@implementation LetraBViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setDelegate:self];
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    [self setTitle:[[iDicionario.items objectAtIndex:iDicionario.pageCount] letra]];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem = next;
    
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(previous:)];
    self.navigationItem.leftBarButtonItem = previous;
    
    UILabel *palavra = [[UILabel alloc] init];
    [palavra setText:[[iDicionario.items objectAtIndex:iDicionario.pageCount] palavra]];
    [palavra setFrame:CGRectMake(CGRectGetMidX([self.view bounds])/2, 100, 0, 0)];
    [palavra sizeToFit];
    [self.view addSubview:palavra];
    
    UIImageView *imagem = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX([self.view bounds])/4, 150, 0, 0)];
    [imagem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [[iDicionario.items objectAtIndex:iDicionario.pageCount] imagem]]]];
    [imagem sizeToFit];
    [imagem setTransform:CGAffineTransformScale(self.view.transform, 0.01, 0.01)];
    [self.view addSubview:imagem];
    [UIView animateWithDuration:1 animations:^{
        [imagem setTransform:CGAffineTransformScale(imagem.transform, 100.0, 100.0)];
    }];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeLeft setDelegate:self];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previous:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeRight setDelegate:self];
    [self.view addGestureRecognizer:swipeRight];
}


#pragma mark Navigation

- (void)previous:(id)sender {
    iDicionarioManager *iDicionario = [iDicionarioManager sharedInstance];
    if (iDicionario.pageCount == 0)
        iDicionario.pageCount = 25;
    else
        iDicionario.pageCount--;
    [self.navigationController setDelegate:nil];
    if (self.navigationController.viewControllers.count == 1) {
        LetraAViewController *anterior = [[LetraAViewController alloc] initWithNibName:nil bundle:NULL];
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
    if (self.navigationController.viewControllers.count == 3)
        [self.navigationController setViewControllers:[NSArray arrayWithObject:self] animated:YES];
    LetraCViewController *proximo = [[LetraCViewController alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:proximo animated:YES];
}


@end
