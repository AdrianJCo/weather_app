# Weather_App

A simple Flutter app that displays the current weather info in London and weather forecasts for the next 5 days. Developed with Android Studio v4.2.2, unfortunately this application is incomplete due to time, the source code compiles as expected but a race condition occurs when accessing the database and therefore the application would not run on the android emulator.

Initially the plan was to obtain data from the weather API, and then persist the data using sqlflite, the database consists of a single table with two columns:
1. An integer for storing the date of the record which also serves as a primary key.
2. The JSON object containing the weather data associated with the date, stored as plain text.

The idea was to retrieve a list of records from the local database in chronological order, which can be displayed whilst the user is off/online.

Other considerations would be to encode the API key or store the API key on a proxy server in order to protect it integrity.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
