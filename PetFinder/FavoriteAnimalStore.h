//
//  FavoriteAnimalStore.h
//  PetFinder
//
//  Created by gregory jean baptiste on 11/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteAnimal.h"

@interface FavoriteAnimalStore : NSObject
{
    NSMutableArray * allFavorites;
}

+(FavoriteAnimalStore *)singletonFavorites;

-(NSArray *)allFavorites;
-(NSString *)itemArchivePath;
-(BOOL)saveChanges;
-(void)addAnimal:(FavoriteAnimal *)newFavorite;
-(BOOL)isDuplicate:(Animal *)theAnimal;
-(void)removeAnimal:(FavoriteAnimal *)theAnimal;

@end
