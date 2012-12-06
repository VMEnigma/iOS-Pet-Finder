iOS-Pet-Finder
==============

Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
https://github.com/raygon3/iOS-Pet-Finder

This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
http://creativecommons.org/licenses/by/3.0/

Introduction
==============
Pet Finder is an iOS app to show animals at a shelter using an online data source. Users can browse through a list of Cats or Dogs and view more details on an animal with the option to contact the shelter by sending an email. While browsing, users can add an animal to the favorites by shaking the phone. Favorite animals are stored in a separate list and can be deleted. Animals added to favorites are stored on the phone so that they will always be shown even if the online data source removes them. Users can also filter animals by Age, Sex and Breed or search by Name and Breed. 

Online Data Source
==============
PetFinder is capable of parsing both CSV and XML data from an online data source. There is an application setting for which data source to use. 

Currently the app uses the following URLs for it’s data: 
CSV - http://www.venexmedia.com/AnimalShelterApp/animals.csv
XML - http://www.venexmedia.com/AnimalShelterApp/animals.xml

Fields: ID, Name, Type, Breed, Description1, Description2, Description3, Sex, Age, Size, ShelterDate

Images path: www.venexmedia.com/AnimalShelterApp/images/
Image file names are in the format of ID.jpeg