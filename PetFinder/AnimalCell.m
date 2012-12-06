//
//  AnimalCell.m
//  PetFinder v1.0
//
//  Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
//  https://github.com/raygon3/iOS-Pet-Finder
//
//  This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
//  http://creativecommons.org/licenses/by/3.0/

#import "AnimalCell.h"
#import "Animal.h"
@interface AnimalCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *breed;
@property (weak, nonatomic) IBOutlet UILabel *shelterDate;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *Size;
@property (weak, nonatomic) IBOutlet UILabel *Age;
@end
@implementation AnimalCell
@synthesize animalImage, name, breed, shelterDate, sex, Age, Size;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setAnimalModel: (Animal *)animal
{
    self.name.text = animal.Name;
    self.breed.text = animal.Breed;
    
    //set date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:animal.ShelterDate];
    self.shelterDate.text = stringFromDate;
    
    //set sex
    self.sex.text = animal.Sex;
    self.sex.textColor = ([animal.Sex isEqualToString:@"F"]) ? [UIColor colorWithRed:0.764706 green:0.513726 blue:0.796079 alpha:1] : [UIColor colorWithRed:0.525490 green:0.698039 blue:0.800000 alpha:1];
    
    //set size
    if ([animal.Size isEqualToString:@"S"])
    {
        self.Size.text = @"Small";
    }
    else if ([animal.Size isEqualToString:@"M"])
    {
        self.Size.text = @"Medium";
    }
    else if ([animal.Size isEqualToString:@"L"])
    {
        self.Size.text = @"Large";
    }
    else
    {
        //Use size from datasource if S, M or L is not used
        self.Size.text = animal.Size;
    }
    
    
    self.Age.text = (animal.Age == 0) ? @"<1yr" : @">1yr";
    
    
    
    
}

@end
