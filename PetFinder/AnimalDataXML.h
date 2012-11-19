//
//  AnimalDataXML.h
//  XMLParser
//
//  Created by Reyneiro Hernandez on 11/18/12.
//  Copyright (c) 2012 Reyneiro Hernandez. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AnimalDataXMLDelegate <NSObject>

-(void)animalDataXMLdidFinishParsing;

@end

@interface AnimalDataXML : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray* animalData;
@property (assign, nonatomic) id <AnimalDataXMLDelegate> delegate;
//@property (strong, nonatomic) NSMutableDictionary* animalOfType;


-(void)populateAnimalData: (NSURL*)xmlURL;
-(void)populateAnimalWithData:(NSData*)data;

-(id)initSingleton;
+(AnimalDataXML*)sharedAnimalData;

@end
