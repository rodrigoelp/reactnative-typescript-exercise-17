# iOS app in a swift project, written in react native and typescript

One of the unfortunate things I've found with react native is how dated the project definition and the language used really is for iOS (and Android). The idea of this exercise is to create a template I can use based in swift that I feel more comfortable working in.

## Steps to create a react native app hosted in a swift project

Be warned, this assumes you have cocoapods installed (and your development environment is mac... because you are doing iOS). Also, read all the steps before following each of those as you work. Pay extra attention to the advise at the bottom of this readme.

### Steps

1. Create a folder to store your project.
1. Let's create an iOS project and place it under the `ios` folder.
1. Let's add a `package.json` file, describing the application name as well as the version of react native we are going to be using.
1. Run `yarn add react react-native`
1. Run `yarn add @types/react @types/react-native --dev`
1. Run `yarn add typescript --dev` (in case you don't have typescript installed globally)
1. Run `tsc --init --pretty --target es2017 --jsx react --sourceMap --module commonjs --outdir ./lib/`. If you do not have typescript installed globally, change the command to `./node_modules/.bin/tsc --init --pretty --target es2017 --jsx react --sourceMap --module commonjs --outdir ./lib/`
1. Access the iOS folder: `cd ios`
1. Next, the ios project is configured to use cocoapods, pointing to the dependencies we have just installed. To start this process, let's init cocoapods `pod init`
1. Then we need to add all the pods for react (check the file added to this repo [here](./ios/Podfile)) * you might nede to include some other libraries to cocoapods based on your needs. For this exercise I am just adding RCTText and RCTImage (settings, network and web socket are kind of a must have).
1. Run `pod install` to install all the cocoapods specified and create the workspace (xcworkspace) we will need to continue working on the swift side.
1. Let's modify the `info.plist` file to include a `NSAppTransportSecurity` to allow http calls to `localhost`
1. Let's create the react native entry point `cd .. && touch index.js`
1. Modify `index.js` to include `import "./lib/";`
1. Let's create in `src` a file called `index.tsx` and we will create a component in it to display a hello world message.
1. At this point, you shouldn't need to do anything to the react native libraries... **but** trying to compile this code is going to be problematic as you will get the same issue reported [here](https://github.com/facebook/react-native/issues/16039). If you have similar issues with other submodules of react native, apply a similar fix, which is to modify the `package.json` file adding the following line to the `scripts` section (just above `"start"`) `"postinstall": "sed -i '' 's/#import <fishhook\\/fishhook.h>/#import <React\\/fishhook.h>/' ./node_modules/react-native/Libraries/WebSocket/RCTReconnectingWebSocket.m",`
1. Getting closer to the final changes. We need now to get swift configured to launch react native, and this is achieved via the `RCTRootView`. Open xcode (the workspace) `open ./ios/swiftly.xcworkspace`
1. In xcode (or your editor of choosing... I like using xcode to change swift files), we need to change the `AppDelegate.swift` file to include the following block:

```swift
let codeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
self.window = UIWindow(frame: UIScreen.main.bounds)
let rootView = RCTRootView(
    bundleURL: codeLocation,
    moduleName: "swiftly", // this name comes from the package.json and AppRegistry.registerComponent("moduleName", ...). It has to match
    initialProperties: nil,
    launchOptions: nil)
let viewController = UIViewController()
viewController.view = rootView
self.window?.rootViewController = viewController
self.window?.makeKeyAndVisible()
```

This code will initialise the application with the react native view as the root for the entire application.

*Remember to include `import React` at the top of the swift file.*

19. With that in, we need to change the `Info.plist` file (if you created the project as a single screen app) to remove the main storyboard reference from the loading. (This can be achieved by clicking on the swiftly project icon and clearing out the field **Main Interface** on the **Deployment Info** section)
1. All that is missing is for you to compile your typescript and run react native `tsc && react-native run-ios`

All done! Congratulations!

## Does facebook has documentation for this?

Sort of... Is [here](https://facebook.github.io/react-native/docs/integration-with-existing-apps.html). I tried to follow it and got a few things consuming a lot of my time because it did not work as expected.

## If I have downloaded/cloned this repo and just want to run it... What do I need to do?

Just follow the shell commands below

```sh
# let's access the folder of the project
cd swiftly/
# Download all the dependencies as those are not commited to the repo.
yarn
# Now that we have downloaded all the dependencies, we need to download the cocoapods
pod install
# Compile ts and tsx files (remember, if you don't have typescript installed globally, add ./node_modules/.bin/tsc)
tsc
# and running the code
react-native run-ios
```

## The learning of this was savage... but, is there a package that does this for me already?

YES but, is maintained a a single person, does not have lots of downloads and the manual way allows you to understand what is going on behind the scenes.

The package is called [React Native Swift](https://www.npmjs.com/package/react-native-swift) (yup... very original). Haven't tried it myself, if you are a user of it and want to share your experiences I will be more than happy to chat about it.

## Things to watch out when doing this

I am the sort of person testing every step as I go along... That means, I got stuck when the `fishhook.h` header file could not be found and manually edited the files as I was trying to get the project to work. **Manual editing of libraries downloaded by npm or yarn is a very bad idea**.

Thankfully, one of the github users in react-native's repo provided a more elegant solution (the usage of `sed`)

For those uninitiated in `sed`... this is a stream editor. It can take a file stream (whatever that is) and apply a regular expression to replace/modify/add/delete text on that stream and save it back. The command we did what it does is:

```sh
# added the command as a reference
# but it works as
# sed -i '<file extension which I said any>' '<regular expression>' <path to file>
sed -i '' 's/#import <fishhook\/fishhook.h>/#import <React\/fishhook.h>/' ./node_modules/react-native/Libraries/WebSocket/RCTReconnectingWebSocket.m
```

The regular expression is a bash regular expression (if you know vim, you will understand it easily)

```
s/ <string to match> / <replacement string> /
```

`s` at the beginning of the string stands for `substitute`
`/` is a delimiter for the string... this is way you need to escape those before "fishhook.h"

The string `s/#import <fishhook\/fishhook.h>/#import <React\/fishhook.h>/` reads as

_"I want to substitute `#import <fishhook/fishhook.h>` with `#import <React/fishhook.h>`"_

You need to apply this change because the cocoapod created by facebook is not optimised for framework (used by swift)... so, you are changing the reference to tell it: "hey, compile it using the framework React with the header of fishhook (required to debug the application)"

You will find a similar issue if you import in your cocoapod `RCTAnimation` with an error saying

```
'RCTAnimation/RCTValueAnimatedNode.h' file not found
```

Instead of importing `RCTAnimation/RCTValueAnimatedNode.h` import `React/RCTValueAnimatedNode.h` your sed command should be able to help you with that.

Cheers!