#  Codebase Decisions and Pattern

The codebase follows MVVM-R
Everything has been kept abstracted for convinient implementation (Data Layer for reference)
The codebase follows two-way binding, for example if user enter an amount on whatever country is selected and then select another country from the list, app will update everything, also will check for validations.
View-Model has all the business and domain logic for the APP.
Data Layer follows complete Abstraction with the seperation of concern.
Added two Unit test to test the main calculation logic & if data is fetched.
Used SPM for loader.
