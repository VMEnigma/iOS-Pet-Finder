//
//  FavoriteAnimal.h
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Animal.h"


@interface FavoriteAnimal : NSManagedObject

@property (nonatomic, retain) NSString * animalID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * breed;
@property (nonatomic, retain) NSString * description1;
@property (nonatomic, retain) NSString * description2;
@property (nonatomic, retain) NSString * description3;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic) int32_t age;
@property (nonatomic, retain) NSString * size;
@property (nonatomic) NSTimeInterval shelterDate;
@property (nonatomic) BOOL validity;
@property (nonatomic) double orderingValue;

-(id)initWithAnimal:(Animal *)theAnimal;

@end
