//
//  Utility.h
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject

+(NSArray*) sortArray:(NSArray*) array forProperty:(NSString*) key ascending:(BOOL) ascending;
+(NSString*) getContentsFromUrlAsString:(NSString*) stringUrl;

@end
