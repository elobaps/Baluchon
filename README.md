# Baluchon

Supports: IOS 11 and above

## Introduction:

The Baluchon's app is a travel application that allows :

* to compare weather of New-York's city and Bordeaux's city
* to translate from French to a language chosen from a list
* to get the exchange rate between euro and dollar currencies

## APIs:

This app uses the following APIs :

* Fixer
* Google translate
* OpenWeatherMap

## Getting started:

To test this application, you need to use API keys for Fixer, Google translate and OpenWeatherMap.

In supporting files's folder, you need to create a file ApiConfig.swift.
It should contain the following informations :

```
struct ApiConfig {
    static let fixerApiKey = "yourApiKey"
    static let googleApiKey = "yourApiKey"
    static let openWeatherMapApiKey = "yourApiKey"
}
```

## Dependency:

* SwiftLint - A tool to enforce Swift style and conventions. [SwiftLint documentation.](https://github.com/realm/SwiftLint "SwiftLint documentation.")

## ScreenShots:

![Screenshot-baluchon](https://user-images.githubusercontent.com/11584683/71643662-8d0af200-2cbc-11ea-9297-b8ca5244cd73.png)
