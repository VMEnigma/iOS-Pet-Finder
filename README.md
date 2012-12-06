iOS-Pet-Finder
==============

Created by Raymond Gonzalez, Reyneiro Hernandez, Gregory Jean Baptiste
https://github.com/raygon3/iOS-Pet-Finder

This work is licensed under the Creative Commons Attribution 3.0 Unported License. To view a copy of this license, visit
http://creativecommons.org/licenses/by/3.0/

Introduction
==============
Pet Finder is an iOS app to show animals at a shelter using an online data source. Users can browse through a list of Cats or Dogs and view more details on an animal with the option to contact the shelter by sending an email. While browsing, users can add an animal to the favorites by shaking the phone. Favorite animals are stored in a separate list and can be deleted. Animals added to favorites are stored on the phone so that they will always be shown even if the online data source removes them. Users can also filter animals by Age, Sex and Breed or search by Name and Breed. Pet Finder refreshes the online data often and if there are any connection problems the user will be alerted with an error. Users can also view contact information of the shelter with a map provided by Google Maps.

Technical details
==============
Class list, index, hierarchy members and diagrams can be found at http://www.venexmedia.com/AnimalShelterApp/html/

*   Favorites are stored using CoreData.
*   Filters (Age, Breed, Name) are stored using a pList.
*   Data is retrieved using a MVCS and Actor design pattern. A completion block is used to retrieve the successfully parsed data or return an error if there are connection problems
*   Data retrieval with error handling is done with NSURLConnection

Online Data Source
==============
PetFinder is capable of parsing both CSV and XML data from an online data source. There is an application setting for which data source to use. 

Currently the app uses the following URLs for it’s data: 
CSV - http://www.venexmedia.com/AnimalShelterApp/animals.csv
XML - http://www.venexmedia.com/AnimalShelterApp/animals.xml

Fields: ID, Name, Type, Breed, Description1, Description2, Description3, Sex, Age, Size, ShelterDate

Images path: www.venexmedia.com/AnimalShelterApp/images/
Image file names are in the format of ID.jpeg

3rd Party Libraries and API
==============
**CHCSV Parser** - https://github.com/davedelong/CHCSVParser
CHCSV Parser is used to parse the the CSV file.

**AsyncImageView** - https://github.com/nicklockwood/AsyncImageView
AsyncImageView is used to asynchronously load the images from the online data source.

**Google Maps API v2** - https://developers.google.com/maps/documentation/staticmaps/
Google Maps API is used to show a map of the shelter location in the information view.

App Breakdown and Usage
==============
*   Main views in the tab bar consists of Dogs, Cats, Favorites, Info.
    * **DogsViewController** - Contains list of dogs
    * **CatsViewController** - Contains list of cats
    * **FavoritesViewController** - Contains list of favorties (Cats and/or Dogs)
    * **InfoViewController** - Contains animal shelter contact information and map.
*   Dogs, Cats and Favorites are a subclass of BaseViewController. **BaseViewController** contains common code such as adding rounded corners the table view, fetching the data, and setting up search.

*   Additional Views:
	* **FilterViewController** is the controller for the filter view. Filter data is loaded using a pList in the applications document directory called **Filter.plist**
	* **DetailViewController** is the controller for the detail view. The image for an animal is loaded asynchronously using AsyncImageView. Users can shake their phone to add an animal to their favorites. Users also send an email to the animal shelter to inquire for more information.

*	Stores:
	* **AnimalStore** - Main store for animal data. Singleton. Loads data with CSV or XML. This is where the paths are found for both data sources.
	* **FavoriteImageStore** - Favorite animal images store. Singleton.
	* **FavortieAnimalStore** - Favorite Animal store. Favorite animals are stored so that they are always available regardless if the online data source has it or not. Core Data.

*	Models:
	* **Animal** - Model for animal with fields: ID, Name, Type, Breed, Description1, Description2, Description3, Sex, Age, Size, ShelterDate
	* **Animals** - Model containing array of animals. Data is loaded with a completion block using **fetchAnimalsWithCompletion:**
	* **FavoriteAnimal** - Model for Favorite animal with same fields as Animal and an extra field for validity.

*	Data Connections:
	* **AnimalConnection** - This class establishes the connection and retrieves data from the CSV or XML datasource depending on the application setting. It uses NSURLConnection for error handling.
	* **AnimalDataParser** - Protocol for parshing populating data with CSV or XML