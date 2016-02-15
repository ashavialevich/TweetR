# TweetR

## Important Note
First of all, thank you for me giving the opportunity for job position with Trov. I am very excited about this opportunity.
Please excuse my unofficial language in this document, but I really wanted to engage with the reviewer. No unprofessionalism or disrespect is intended at all, it's actually - quite the opposite of that.

## Heads Up 
If possible, please test the application on a device or at least on a simulator with enabled keyboard due to some of the UI specific interactions. Although app is using autolayout, some parts, like sign up and sign in screen are not optimized for shorter screens and landscape mode. It will be best to use iPhone 6 and 6+.

## Thought Process
Although this project is a simple coding exercise/example app, from the get go, I thought of the project from the maintainability and extensibility point of view. So the application was designed and architected as a "large project". Of course with certain limitations, this is, for obvious reasons, an immitation of the large project architecture.

## Tools Choice
1. Web services
    In this project I have used a soon retiring Parse Framework (good karma to the engineers at parse.com). The choice was made on the basis of the quickest/easiest way to get web service backend integrated into the app.
2. Local Storage
    For local storage, I have chosen CoreData as it is native ORM framework, giving the ability and support for OOP, it is widely popular and is an extremely powerful framework. Confession: I am not a CoreData expert, in fact, I haven't really dealt with CoreData for over two years. Reason - clients I have worked with recently are strongly regulating local device storage for understandable security reasons. I do have plenty of experience with other ORM frameworks, for instance ASP.NET's Entity Framework. With that said, I had to take a "crush course" on CoreData in the evening in order to brush up on the technology and complete the exercise.
3. Dependency Managenment
    CocoaPods - quick, easy, clean.

## Project Structure
Project is divided into 10 major groups

### 1. Data Providers
These are "the shakers and the movers" of the application data supply. Data providers are broken up into 2 categories: web service client and local storage client. What I tried to accomplish in this exercise is that Application is concerned only about view models that are separated into different layer from domain/business models. Application knows that the generic WebServiceClient and LocalStorageClient expose public API that application can call into to get the view models it needs for it's consumtion. App doesn't care about the internal implementations of the web service and local storage clients. Web service client in our application just happens to internally use parse.com (ParseClient - is a concrete implementation of the WebServiceClient). I did not go all the way to abstract CoreDataClient, although ideally it should be structured the same or at least similar way as WebServiceClient. Application should be calling into generic LocalStorageClient and if CoreDataClient happens to be doing all the internal work - so be it

### 2. Models 
Models are broken up into 3 categories web service models, local storage models and view models. This design supports the above mentioned architecture, where app is only concerned about the view models it needs to display/consume. This design allows for maximum adaptability in case of future changes to underlying business/domain models. In case of possible change of domain models, application would consume it's view models exactly the same way it did before. Only the internal bindings within model adapter would ever need to change. Which brings us to the next component of the application - ModelAdapter.

### 3. Model Adapter
This is the class responsible for every possible model "translation" within the application. I only have very limited set of "translations" implemented right now, but the idea is that model adapter would provide two-way WebServiceModel-LocalStorageModel-ViewModel bindings in order to abstract application, WebServiceClient and LocalStorageClient from the models' implementations.

### 4. Utilites 
The name of this app's module/group speaks for itself. One thing to mention - I had come up with "generic" form validation logic that is being utilized on user sign up and sign in screens. Forms can be messy, and maybe it was an overkill for the coding exercise, I decided to give it a shot. 

### 5. UI Components, Theming 
There are a couple of common UI components in the app, they are not much, but I hate copy/pasting :) All of those components expose exactly the customization I need, not much beyond that, but the idea is that those components (along with others) can be easily extended to allow for more fine-grain customization.

### 6. Other Groups
Yes I know, I said 10 major groups above, not 6 :) But his group contains: View Controllers, View Controller Nibs, Cells, Cell Nibs, Theming - all of which are very self explanatory.

## Testing 
This is a tricky one as you all may know!! :) Although I am very familiar with Apple and some of the third-party testing frameworks, I did not include test with this exercise :( The reason, for this is that good, useful testing in a lot of cases requires almost the same amount of code as the application itself. I simply didn't want to write "token" tests, so I could just say I did it. In some cases bad tests are worse than no tests. They add to maintainability issues greatly as well as bringing a whole lot of false-positives. However, I would like to take you through the process and approaches I normally take when testing my applications. First of, let's start with unit tests. White box testing is crucial to the core components testing. I case of the coding exercise app, although, it's a very simple project, unit testing may not be as trivial as one would think. For instance testing the web service client. In this case testing the web services themselves are important, but your testing should not rely on success/failure scenario (unfortunately web requests fail for independent of us reasons). For such components I would normally set separate configurations - LiveTests and MockDataTests that would be build separate on CI server. This allows to not only quicker identify issues with the web services, but to also prove that your component's logic in the application is functioning properly and is not the cause of the issue. This would require mock data set up, two separate sets of tests etc. But ultimately all of the core components' public API tests is a must in the production application. Regarding UI tests and integration tests, again, things are not very trivial here and would require specific set up, before this is possible. Coding exercise is heavily user-based. So both unit test and automation tests would also require different build configurations setup, so that the respective targets could hook into the "development environment", deal with test user accounts, clean up it's own data at the end of the tests. I hope that tests exclusion will not affect your decision drammatically, because in my opinion to set up proper tests would take quite a bit more, and I wanted to engage into conversation with you rather sooner. Again, I didn't want to write "bad tests" - they are not helpful at all. 

## Documentation
Extra documentation in the code is provided.



