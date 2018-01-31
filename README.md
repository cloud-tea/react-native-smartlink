
# react-native-smart-link

## Getting started

`$ npm install react-native-smart-link --save`

### Mostly automatic installation

`$ react-native link react-native-smart-link`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-smart-link` and add `RNSmartLink.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNSmartLink.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNSmartLinkPackage;` to the imports at the top of the file
  - Add `new RNSmartLinkPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-smart-link'
  	project(':react-native-smart-link').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-smart-link/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-smart-link')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNSmartLink.sln` in `node_modules/react-native-smart-link/windows/RNSmartLink.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Smart.Link.RNSmartLink;` to the usings at the top of the file
  - Add `new RNSmartLinkPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNSmartLink from 'react-native-smart-link';

// TODO: What to do with the module?
RNSmartLink;
```
  