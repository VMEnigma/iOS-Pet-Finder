//
//  XMLAnimalController.h
//  PetFinder
//
//  Created by Reyneiro Hernandez on 12/5/12.
//
//

#import <Foundation/Foundation.h>

@protocol XMLAnimalControllerDelegate <NSObject>

-(void)xmlAnimalControllerDelegateDidFinishParsing;

@end

@interface XMLAnimalController : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray* animalData;
@property (assign, nonatomic) id <XMLAnimalControllerDelegate> delegate;


-(BOOL)loadAnimalData: (NSURL*)xmlURL;
-(BOOL)loadAnimalWithData:(NSData*)data;

@end
