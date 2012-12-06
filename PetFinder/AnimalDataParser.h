//
//  AnimalDataParser.h
//  PetFinder
//
//  Created by Raymond Gonzalez on 12/5/12.
//
//

#import <Foundation/Foundation.h>

@protocol AnimalDataParser <NSObject>

- (void) populateAnimalData: (NSArray*)dataArray;

@end
