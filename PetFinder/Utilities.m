//
//  Utility.m
//  PetFinder
//
//  Created by Raymond G on 11/12/12.
//
//

#import "Utilities.h"

@implementation Utilities

//(RG) - Get Contents of URL as NSString
+(NSString*)getContentsFromUrlAsString:(NSString*) stringUrl
{
    return [[NSString alloc]
            initWithContentsOfURL: [[NSURL alloc]
                                    initWithString: stringUrl]
            encoding:NSUTF8StringEncoding error:nil];
}

//(RG) - Get filter plist path
+(NSString*)getFilterPath
{
    //Get Filter data from Plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Filter.plist"];
}

@end
