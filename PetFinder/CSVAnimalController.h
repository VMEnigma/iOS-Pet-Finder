//
//  CSVAnimalController.h
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import <Foundation/Foundation.h>

@interface CSVAnimalController : NSObject

-(id) initWithStringUrl: (NSString*)url;
-(NSArray*) getAnimalDataAsArray;

@end
