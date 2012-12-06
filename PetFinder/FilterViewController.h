//
//  FilterViewController.h
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import <UIKit/UIKit.h>

// (RG)
@interface FilterViewController : UIViewController

@property (weak, nonatomic) id delegate;


-(void)doneFilter;

@end
