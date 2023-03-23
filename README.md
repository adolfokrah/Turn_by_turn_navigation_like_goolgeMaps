# google_maps_navigation

![Screenshot 2023-03-23 at 3 08 13 PM](https://user-images.githubusercontent.com/37264779/227229562-bd7e6d38-49e7-4af7-b51f-85842ad7bd18.png)


## Getting Started

Get here your google api here https://cloud.google.com/
make sure you have all these apis enabled

Directions API<br/>
Geocoding API<br/>
Maps SDK for iOS<br/>
Maps SDK for ANDROID<br/>
Places API<br/>
Distance Matrix API<br/>
Routes API<br/>

in .env put your google maps api key here <br/>
`GOOGLE_MAPS_API_KEY=GOOGLE_MAPS_API_KEY`

and in your `ios/Runner/AppDelegate.swift` put your google maps api here <br/>
` GMSServices.provideAPIKey("GOOGLE_MAPS_API_KEY")`

same as `android/app/src/main/AndroidManifest.xml` <br/>
` <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="GOOGLE_MAPS_API_KEY"/>`
