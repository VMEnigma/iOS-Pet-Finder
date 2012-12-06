//
//  Animals.h
//  PetFinder
//
//  Created by Raymond Gonzalez on 12/5/12.
//
//

#import <Foundation/Foundation.h>
#import "CHCSV.h"
#import "AnimalDataParser.h"

@interface Animals : NSObject <NSXMLParserDelegate, AnimalDataParser>
{
    NSMutableString *currentString;
}

@property (weak, nonatomic) id parentParserDelegate;

@property (strong, nonatomic) NSMutableArray* animalData;
@property (strong, nonatomic) NSMutableDictionary* animalOfType;
@property (strong, nonatomic) NSMutableDictionary* animalOfSex;
@property (strong, nonatomic) NSMutableDictionary* animalOfSize;
@property (strong, nonatomic) NSMutableDictionary* animalOfAge;


-(id)returnFilteredWithAnimalData: (id)currentData;



@end
