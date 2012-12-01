//
//  FavoriteAnimal.h
//  PetFinder
//
//  Created by gregory jean baptiste on 11/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animal.h"

@interface FavoriteAnimal : NSObject <NSCoding>

@property (copy, nonatomic) NSString* AnimalID;
@property (copy, nonatomic) NSString* Name;
@property (copy, nonatomic) NSString* Type;
@property (copy, nonatomic) NSString* Breed;
@property (copy, nonatomic) NSString* Description1;
@property (copy, nonatomic) NSString* Description2;
@property (copy, nonatomic) NSString* Description3;
@property (copy, nonatomic) NSString* Sex;
@property (strong, nonatomic) NSNumber* Age;
@property (copy, nonatomic) NSString* Size;
@property (strong, nonatomic) NSDate* ShelterDate;
@property BOOL validity;

-(id)initWithAnimal:(Animal *)theAnimal;

@end
