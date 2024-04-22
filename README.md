# StarzPlay

## Architecture:
- I have used Clean Swift (VIP) architecture in this application to showcase my knowledge and grip of this architecture,
The main benefits of this architecture are separation of concerns, easy dependency injection unit testing, etc.

## Instructions to Run the Application:
- Open the terminal at the app root folder i.e. StarzPlay and run the command *pod install* now you should be able to run the app smoothly.
- Open the directory **StarzPlay** and then double click on the file **StarzPlay.xcworkspace** app will be launched on XCode now you can easily run and test it.

## Areas of Improvement (Self-Identified):
After completing the core part of the assignment I have identified the mentioned areas of improvement to further improve and enhance the application.
- Support all device orientations
- Proper Dark Theme support in UI (It is handled in Assets)
- Unit Test implementation (I have implemented some unit tests to showcase my knowledge of XCTest, thou some of the test cases are not being passed but that is known)
- UI Tests implementation
- Display details on a new screen when an episode cell is tapped by user, also implement collapsable cell functionality to show further details.
- In my opinion top header should collapse (minimised) with the tableView/episodes scrolling upwords and should display again with animation while scrolling down
- Implemented the APIManager using generics that could easily be transormed to a pod but couldn't do so because of time constraint
- Network connectivity handling, otherwise display error to user if tries to fetch remote info

## Libraries Used:
- I have used Cocoapods:
- SDWebImage is used download and display images in the lists seamleasly from internet
- Moya is used to maintain code quality even while writing it from scratch
- Moya is used to simplify the API calls and to make it very clean and scalable (which is using Alamofire).

## Known Issues:
I have tried to complete the application as per the requirements but a few minor know issues are below:
- As per UI currently selected season should be underline too
- Missing functionalities of some buttons i.e. download, like, dislike etc.
- *Disclaimer: I have downloaded the resources from the internet which are being used in the app*
