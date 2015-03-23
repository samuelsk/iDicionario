//
//  ItemDicionario.h
//  Navigation
//
//  Created by Samuel Shin Kim on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface ItemDicionario : RLMObject

@property (strong, nonatomic) NSString *letra;
@property (strong, nonatomic) NSString *palavra;
@property (strong, nonatomic) NSData *imagem;
@property (strong, nonatomic) NSDate *dataModif;

- (id)initWithLetra:(NSString *)newLetra andPalavra:(NSString *)newPalavra andImagem:(UIImage *)newImagem;

- (UIImage *)getDataImage;
- (void)dataWithImagem:(UIImage *)newImagem;

@end
