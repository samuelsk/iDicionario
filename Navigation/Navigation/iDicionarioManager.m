//
//  iDicionarioManager.m
//  Navigation
//
//  Created by Samuel Shin Kim on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "iDicionarioManager.h"
#import <Realm/Realm.h>

@implementation iDicionarioManager

static iDicionarioManager *singleton = nil;
static bool isFirstAccess = YES;


#pragma mark - Dicionário

+ (id)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        singleton = [[super allocWithZone:NULL] init];
    });
    return singleton;
}

- (id)init {
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
        RLMResults *results = [ItemDicionario allObjects];
        for (ItemDicionario *item in results)
            [self.items addObject:item];
    }
    return self;
}

- (void)resetarDicionario {
    [self.items removeAllObjects];
    NSArray *palavras = @[@"Adventure Time", @"Batman Beyond", @"Courage the Cowardly Dog", @"Dexter's Laboratory", @"Earthworm Jim", @"Futurama", @"Gravity Falls", @"He-Man", @"Invader Zim", @"Johnny Bravo", @"Kim Possible", @"Looney Tunes", @"Megas XLR", @"Neon Genesis Evangelion", @"Ozzy & Drix", @"Pinky and the Brain", @"Quick Draw McGraw", @"Robot Chicken", @"Samurai Jack", @"ThunderCats", @"Underdog", @"Voltron", @"Woody Woodpecker", @"Xiaolin Showdown", @"Yu-Gi-Oh!", @"Zatch Bell!"];
    int palavraCount = 0;
    for (int i = 'A'; i <= 'Z'; i++) {
        [self.items addObject:[[ItemDicionario alloc] initWithLetra:[NSString stringWithFormat:@"%c", i] andPalavra:[NSString stringWithFormat:@"%@", [palavras objectAtIndex:palavraCount]] andImagem:[UIImage imageNamed:[NSString stringWithFormat:@"%c", i]]]];
        palavraCount++;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm addObjects:self.items];
    [realm commitWriteTransaction];
}


#pragma mark Busca

- (int)buscaPalavra:(NSString *)termo {
    for (int i = 0; i < self.items.count; i++) {
        if ([[self formatarTermo:[[self.items objectAtIndex:i] palavra]]
             containsString:[self formatarTermo:termo]])
            return i;
    }
    return -1;
}

- (NSString *)formatarTermo:(NSString *)termo {
    termo = [termo stringByReplacingOccurrencesOfString:@" " withString:@""];
    termo = [termo stringByReplacingOccurrencesOfString:@"-" withString:@""];
    termo = [termo lowercaseString];
    return termo;
}

@end
