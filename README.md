# AtoB---An-iOS-Application

November 2016-December 2016

•	Compares multiple leading online transportation applications based on estimates of time for pickup, time to destination and cost to help the user make the most informed choice

•	Developed using Objective-C, Firebase Platform for authentication, APIs like Google Maps, Places, Distance Matrix and Postman Platform for testing public APIs and understanding response content

## Introduction
Let’s start with a scenario. Amy is a student who has to visit a party at a friend’s place…something she has been looking forward to for a while now. She doesn’t own a car and is really hoping for a cheap and quick ride to get to the party. She has multiple options for a ride like Uber and Lyft, but which one is the most convenient? That’s where A to B comes into picture…

### OBJECTIVE OF A TO B
A to B is an iOS application that users can use to compare ride options provided by Uber and Lyft to make a decision about which service can be used based on estimated price and estimated time of arrival of the driver to the pick-up location. The objective is to present the user with detailed information regarding the available ride options (maybe individual or carpool) and compare services against corresponding costs and time estimates so that user can make an informed decision about the ride service that they want to use without having to toggle between different applications.

“Choose wisely”
A to B provides a one stop information detailing based on the user’s current location and the chosen destination location. So that the user can choose wisely.


### Technologies Used

To develop A to B the following technologies were used:
#### EDITOR
•	Xcode 7.1.1
#### PROGRAMMING LANGUAGE
•	Objective-C
#### SIMULATOR 
•	iPhone 6 was used to simulate the application behavior on a device
#### SIMULATE API CALLS AND RECEIVE RESPONSE 
•	For testing public API calls and understanding response content, the Postman tool was used
#### AUTHENTICATION 
•	For secure login, sign-up and forgot-password functionality Firebase tool was used that provides infrastructure for application development namely; Authentication, Database, Analytics etc.


#### PUBLIC APIS USED
•	In order to get location based services and to get ride request information the following Public APIs were used:
		
Google Maps API	  
RESPONSE TYPE: json	  
FEATURE: Used to set up a Map with the user’s current location set on the Map with the help of a marker and also mark the destination location after user selects the destination

Google Places API	  
RESPONSE TYPE: json	  
FEATURE: Used to get Place name for the user’s current Latitude and Longitude  
         Used to get Place Autocomplete functionality of Google Places API to make the destination search bar intuitive.

Google Distance-Matrix API	  
RESPONSE TYPE: json	  
FEATURE: Used to get the distance from the user’s current location (source_latitude, source_longitude) to the destination location (destination_latitue,destination_longitude) after user selects destination.

Google Directions API	    
RESPONSE TYPE: json	    
FEATURE: Used to get the closest route from user’s current location and selected destination and plot on the Google Map.

Uber Cost API	    
RESPONSE TYPE: json	    
FEATURE: Used to get the estimated maximum cost of travel after selecting source and destination and a server token that is received after registering application with the Uber developer’s website (GET request).

Uber Time API	  
RESPONSE TYPE: json	  
FEATURE: Used to get the estimated time for the nearest Uber driver to arrive at the pick-up location after the user enters the destination location (GET request).

Lyft Cost_Estimate API	  
RESPONSE TYPE: json	  
FEATURE: Used to get the estimated maximum cost of travel after selecting source and destination and a access token that is received after registering application with the Lyft developer’s website using a POST request.

Lyft eta_estimate API	  
RESPONSE TYPE: json		  
FEATURE: Used to get the estimated time for the nearest Uber driver to arrive at the pick-up location after the user enters the destination location using the access token (GET request).

		
