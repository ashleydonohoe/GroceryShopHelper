# Grocery Shop Helper

Grocery Shop Helper is a web-enabled app that allows users to add items to their grocery list and get an up-to-date list of nearby grocery stores based on their location. This app is suitable for anybody who goes grocery shopping and wants an easy way to keep track of the items they need and find nearby stores no matter where they go.

## Using the Grocery List
The first tab of the application is a grocery list presented as a table with two segments: All Items and Favorite Items. Users can tap any existing item, which is stored in permanent storage using Core Data, and see the item's information. When seeing the item's information, there's a star button the user can click to save or remove that grocery item to their favorites list. Favorite items have a red star filled in for easy identification on both the table and the item info page.

The user adds an item and its information by tapping a plus sign icon on the top right of the screen. The user is presented with fields to add an item name, category, quantity, price, and image. Adding an image is optional and not needed to save the item. Once the user selects to save the item, they're taken back to the grocery list table with the new item added.

## Using the Nearby Store Search
The second tab of Grocery Shop Helper allows users to download an up-to-date list of stores within a 3 to 10 mile radius of their current location. Using this feature requires the user to enable location services and agree to having Grocery Shop Helper have access to their current location. Once this is approved, the app will attempt to grab a list of 20 grocery stores using the Google Places API, and an activity indicator appears on the screen to show this in progress. 

The user is alerted if a network issue or permissions issue causes no stores to download. Otherwise, the user sees a list of 20 store names. Tapping one of these brings up a details screen with the store name, address, review rating (if available) and price range (if available). Below this informatio is a satelite map view with a marker for the store. Tapping the marker presents the option to get directions to the selected store using Apple Maps.

## Changing Settings
The user has control over how far they want the store results to be on the third tab named Settings. The default setting is 3 miles, while the user has options to choose 5 or 10 miles. The user saves the setting, which immediately takes effect. This setting is stored using UserDefaults.

