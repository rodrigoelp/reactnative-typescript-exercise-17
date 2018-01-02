# iOS app in a swift project, written in react native and typescript

One of the unfortunate things I've found with react native is how dated the project definition and the language used really is for iOS (and Android). The idea of this exercise is to create a template I can use based in swift that I feel more comfortable working in.

## Steps to create a react native app hosted in a swift project

Be warned, this assumes you have cocoapods installed (and your development environment is mac... because you are doing iOS)

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
