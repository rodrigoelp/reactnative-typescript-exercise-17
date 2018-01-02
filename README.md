# iOS app in a swift project, written in react native and typescript

One of the unfortunate things I've found with react native is how dated the project definition and the language used really is for iOS (and Android). The idea of this exercise is to create a template I can use based in swift that I feel more comfortable working in.

## Steps to create a react native app hosted in a swift project

Be warned, this assumes you have cocoapods installed (and your development environment is mac... because you are doing iOS)

1. Let's create an iOS project and place it under the `ios` folder.
1. Let's add a `package.json` file, describing the application name as well as the version of react native we are going to be using.
1. Next, the ios project is configured to use cocoapods, pointing to the dependencies we have just installed.
