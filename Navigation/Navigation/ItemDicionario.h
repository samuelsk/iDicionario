//
//  ItemDicionario.h
//  Navigation
//
//  Created by Samuel Shin Kim on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemDicionario : NSObject

@property (strong, nonatomic) NSString *letra;
@property (strong, nonatomic) NSString *palavra;
@property (strong, nonatomic) UIImage *imagem;
@property (strong, nonatomic) NSDate *dataModif;

- (id)initWithLetra:(NSString *)newLetra andPalavra:(NSString *)newPalavra andImagem:(UIImage *)newImagem;

@end
