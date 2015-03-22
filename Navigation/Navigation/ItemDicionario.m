//
//  ItemDicionario.m
//  Navigation
//
//  Created by Samuel Shin Kim on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "ItemDicionario.h"

@implementation ItemDicionario

- (id)initWithLetra:(NSString *)newLetra andPalavra:(NSString *)newPalavra andImagem:(UIImage *)newImagem {
    self = [super init];
    if (self) {
        [self setLetra:newLetra];
        [self setPalavra:newPalavra];
        [self setImagem:newImagem];
    }
    return self;
}

@end
