//
//  FavoriteAnimalStore.h
//  PetFinder
//
//  Created by gregory jean baptiste on 11/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteAnimal.h"
#import <CoreData/CoreData.h>

@interface FavoriteAnimalStore : NSObject
{
    NSMutableArray * allFavorites;
    NSManagedObjectContext * context;
    NSManagedObjectModel * model;
}

+(FavoriteAnimalStore *)singletonFavorites;

-(NSArray *)allFavorites;
-(NSString *)itemArchivePath;
-(BOOL)saveChanges;
-(void)addAnimal:(FavoriteAnimal *)newFavorite;
-(FavoriteAnimal *)createFavoriteAnimal;
-(BOOL)isDuplicate:(Animal *)theAnimal;
-(void)removeAnimal:(FavoriteAnimal *)theAnimal;
-(void)loadAllItems;

@end
