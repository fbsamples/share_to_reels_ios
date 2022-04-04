# Share to Reels

## iOS Sample App

This is an iOS Sample app with an integration to Facebook Share to Reels. Once you run the app, you will reach a screen where you can upload a video from your gallery and share to Reels in the Facebook App.

## Required software

In order to run the sample app you will need to install some required software, as follows:

- XCode

## Add your app id

In order to run the app, you will need to update the code and add your Facebook Developer App Id. If you don't have an app, check out this [link](https://developers.facebook.com/docs/development/).

Update the following files:
- `iOS ShareToReels/ContentView.swift`

You will need to fill in your app id in the `"YOUR_APP_ID"` strings.

## Running the project

1. Open the sample app project on XCode.
3. Enable dev mode on your iOS Phone*.
4. Connect your phone to your Mac using a USB cable.
5. Your phone should appear on the devices tab in XCode.
6. Select your phone and click on the play button. The app will be built and executed in you mobile device.


> **Enabling dev mode on your iOS Phone**
>- To run the sample app on your mobile device you need to create an "Apple Development" certificate.
>   1. Click on the project root from the left menu and select the "Signing & Capabilities" tab.
>   2. Click in the Team dropdown and select "Add an Account".
>   3. Click on the :heavy_plus_sign: icon to add an account.
>   4. Sign in with your Apple ID.
>   5. Click on "Manage Certificates…" button to make sure it has a certificate.
>   6. If no certificate is listed, click on the :heavy_plus_sign: icon and select "Apple Development" to create the development certificate.
>   7. Once you link your Apple account and it has a developer certificate, go back to "Signing & Capabilities". In the "Team" field, select your personal team.
>- Now you need to trust your computer and development team app on your mobile device.
>   1. Unlock your phone and connect to your laptop using the cable. A message will  display on your phone:
>   2. Trust apps from your Apple Development team. Open Setting :arrow_right: General :arrow_right: VPN & Device Management. Under "Developer App", select in the Item of the team account you just linked to the project.

## License
Share to Reels iOS is Meta Platform Policy licensed, as found in the LICENSE file.
