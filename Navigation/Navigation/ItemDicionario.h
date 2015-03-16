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
@property (strong, nonatomic) NSString *imagem;

- (id)initWithLetra:(NSString *)newLetra andPalavra:(NSString *)newPalavra andImagem:(NSString *)newImagem;

@end
