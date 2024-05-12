# ShareTrip

ShareTrip is a test project written in SwiftUI using MVVM for a job application.

NOTE. In order to be able to execute this application a Google Maps API key needs to be provided.
      Add your valid Google Maps API key in: ShareTrip -> Support folder -> credentials.plist. 
      Type your api key into field value for key: 'GoogleMapsAPIKey'

Basic specifications:
You are asked to build a simple trip manager for our bus on demand solution. This tool will be used by the operators of the service in order to see the trips available in the system. The problem has three tasks and you should solve each one before the next.

Required tasks:

Task 1: Trip list:
    - Goal:
        The initial screen should show a map and scrollable list of the current available trips.
    - Guide:
        - Each trip card should show some information: driver name, timestamps,...
        - You can choose what you think is more important.

Task 2: Select trip:
    - Goal:
        When we click on one trip, it should be shown on the map. (map centers and zooms towards it)
    - Guide:
        - The route of the trip and the points of each stop should be shown on the map. Also the start and finish points of the trip.
        - The map should be centered on the route and zoomed.
        - It should be clear to the user which trip has been selected.
        - The route returned by the API is a google encoded polyline. (check this) 
        - You can use this third-party library to represent the polyline on the map if you want to.

Task 3: Stop info:
    - Goal:
        When we click on one stop, a popup with the information of the stop should be shown.
    - Guide:
        - Each stop bubble should show some information about it: passenger, time,... You can choose what you think is more important.


Task 4: Contact form:
    - Goal:
        On the main screen we should be able to open a contact form in order to report an issue.
    - Guide:
        - The form should ask the name and surname of the user, email, phone (non-mandatory field), date and time of the reporting bug and a multiline input text (200 characters max) for the report description.
        - This data should be validated and stored locally (you don’t need to send it to a server).
        - The application’s icon badge number should display the total number of stored issues.

Extra considerations.
    - Used react programing
    - Added also location manager (CoreLocation) to show current position.
    - Added tests. 
    - Using Core Data to persist data from report form. Enhancement, it could be to use core data to store trips, and add an "offline" feature.
    - Dark mode is not implemented at this point.
    - Third party libraries used Google Maps and Polyline (via Swift Package)
