//
//  Animal.h
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject


//Animal fields to make fast enumuration clearer to read
enum AnimalFields { AnimalID, Name, Type, Breed, Description1, Description2, Description3, Sex, Age, AnimalSize, ShelterDate };

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

-(id)initWithAnimalId: (NSString *)animalID andName: (NSString*)name andType: (NSString*)type andBreed: (NSString*)breed andDescription1: (NSString*)description1 andDescription2: (NSString*)description2 andDescription3: (NSString*)description3 andSex: (NSString*)sex andAge: (NSNumber*)age andSize: (NSString*)size andShelterDate: (NSDate*)date;


@end
