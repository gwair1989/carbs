# Carbs
![]()
#### Video Demo:  https://youtu.be/F4PoatC4mFg
#### Description: 
My Final Project name is Carbs
This is a calculator of calories, proteins, fats and carbohydrates.
You can calculate the recommended amount of consumption for your purposes.
As we can see the view on all devices will be the same or similar. 

After filling out the fields, we can calculate
After calculation, we can see calories, protein, fats, carbs recommended for consumption
When we tap "Buy premium" You can see the recommended amount of consumption for losing and raising weight
if we click on the recalculate we will return to the first screen

The project was implemented on the MVC architecture

#####In Model :
- We have a model - BMR
This is a data storage model

- We have a brain - BmrBrain
Here we conduct all calculations according to the formula
In getBMR function we get User parameters and we calculate to maintain, Losing and Raising weight
Append in the array

In getPFC function we calculate proteins, fats and carbohydrates 

In formatData we are formated Float

####In Controller: 
- We have CalculateVC and RecalculateVC

In CalculateVC We have properties that will receive user data
indexGender - After choosing the gender, the desired index will be substituted in the formula. This is necessary according to the formula.
bmrBrain - Exploration of the structure BmrBrain
isGender - Boolean variable responsible for the chosen gender

I use blurView for show infoLabel

enterData function - Checks the fullness of the fields
textFieldShouldReturn -  We hide the keyboard pressing on Return/Done


In RecalculateVC We have the properties of the output of the results
    setupUI(numberOfSegment: Int) function -  Since the data is stored in the array, we can get access to them according to the selected index in UISegmentedControl
    
    setupUI(), setupBlurView, setupLabel function for settings UI


In View
- We have files of storyboard and Launcscreen
In file storyboard I am implementing a user interface


I demonstrated the possibility of creating view  in the storyboard and in the code
I reuse methods for UI and recalculate if we want to see more data


