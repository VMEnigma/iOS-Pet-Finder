//
//  AnimalData.h
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import <Foundation/Foundation.h>

@interface AnimalData : NSObject

@property (strong, nonatomic) NSMutableArray* animalData;
@property (strong, nonatomic) NSMutableDictionary* animalOfType;
@property (strong, nonatomic) NSMutableDictionary* animalOfSex;
@property (strong, nonatomic) NSMutableDictionary* animalOfSize;
@property (strong, nonatomic) NSMutableDictionary* animalOfAge;


-(void)populateAnimalData: (NSArray*)dataArray;
-(void)populateAnimalDataFromXMLParser: (NSArray*)dataArray;
-(id)initSingleton;
+(AnimalData*)sharedAnimalData;
-(id)returnFilteredWithAnimalData: (id)currentData;


@end
