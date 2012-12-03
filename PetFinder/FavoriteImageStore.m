//
//  FavoriteImageStore.m
//  PetFinder
//
//  Created by Gregory Jean-Baptiste on 12/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoriteImageStore.h"

@implementation FavoriteImageStore

+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedImages];
}

+(FavoriteImageStore *)sharedImages
{
    static FavoriteImageStore * sharedImages = nil;
    
    if(!sharedImages)
    {
        sharedImages = [[super allocWithZone:NULL] init];
    }
    
    return sharedImages;
}

-(id)init
{
    self = [super init];
    
    if(self)
    {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
    
    //create full path for image
    NSString * imagePath = [self imagePathForKey:s];
    
    //turn image into jpeg data
    NSData * d = UIImageJPEGRepresentation(i, 0.5);
    
    //write it to full path
    [d writeToFile:imagePath atomically:YES];
}

-(UIImage *)imageForKey:(NSString *)s
{
    //return [dictionary objectForKey:s];
    
    UIImage * result = [dictionary objectForKey:s];
    
    if(!result)
    {
        result = [UIImage imageWithContentsOfFile:[self imagePathForKey:s]];
        
        if(result)
        {
            [dictionary setObject:result forKey:s];
        }
        else
        {
            NSLog(@"Error: Unable to find %@", [self imagePathForKey:s]);
        }
    }
    
    return result;
}

-(void)deleteImageForKey:(NSString *)s
{
    if(!s)
    {
        return;
    }
    
    [dictionary removeObjectForKey:s];
    
    NSString * path = [self imagePathForKey:s];
    
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

-(NSString *)imagePathForKey:(NSString *)key
{
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}




@end
