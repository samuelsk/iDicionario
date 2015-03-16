//
//  iDicionarioManager.h
//  Navigation
//
//  Created by Samuel Shin Kim on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemDicionario.h"

@interface iDicionarioManager : NSObject

@property (nonatomic) int pageCount;
@property (strong, nonatomic) NSMutableArray *items;

+ (iDicionarioManager *)sharedInstance;
- (void)fillItems;

@end
