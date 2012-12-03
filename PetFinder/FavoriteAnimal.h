//
//  FavoriteAnimal.h
//  PetFinder
//
//  Created by Gregory Jean-Baptiste on 12/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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
