//
//  AnimalData.h
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import <Foundation/Foundation.h>

@interface AnimalData : NSObject

@property (strong, nonatomic) NSMutableArray* animalData;
@property (strong, nonatomic) NSMutableDictionary* animalOfType;
@property (strong, nonatomic) NSMutableDictionary* animalOfSex;
@property (strong, nonatomic) NSMutableDictionary* animalOfSize;
@property (strong, nonatomic) NSMutableDictionary* animalOfAge;


-(void)populateAnimalData: (NSArray*)dataArray;
-(id)initSingleton;
+(AnimalData*)sharedAnimalData;
-(id)returnFilteredWithAnimalData: (id)currentData;


@end
