//
//  FavoriteImageStore.h
//  PetFinder
//
//  Created by Gregory Jean-Baptiste on 12/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteImageStore : NSObject
{
    NSMutableDictionary * dictionary;
}

+(FavoriteImageStore *)sharedImages;

-(void)setImage:(UIImage *)i forKey:(NSString *)s;
-(UIImage *)imageForKey:(NSString *)s;
-(void)deleteImageForKey:(NSString *)s;
-(NSString *)imagePathForKey:(NSString *)key;

@end
