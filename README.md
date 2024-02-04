# currency_converter_app

A new Flutter project.

# Getting Started

This project is a starting point for a Flutter application.

# How Build the project

# Implement Clean Architecture:
In the presentation layer, create your UI components, screens, and presenters.
In the domain layer, define use cases, and repositories.
In the data layer, implement data sources, repositories, and models.

# Use BLoC for state management:
Use the BLoC pattern to manage the state of your application. Create a BLoC for each feature of your application. The BLoC will handle the business logic and state of the feature.

# Dependency Injection:
Used get_it for dependency injection. Register your dependencies in the main.dart file.

## You have made a choice clear architecture of design pattern for this project?

Separation of Concerns:
Clear division between layers for better maintainability.

Testability:
Isolation of business logic for efficient unit testing.

Flexibility:
Components can be changed without affecting others.

Dependency Inversion:
Adheres to the Dependency Inversion Principle for modular code.

Maintainability:
Organized structure for easier navigation and code understanding.

Easier Collaboration:
Different teams can work on separate layers independently.

Code Reusability:
Encourages the creation of reusable components.

Scalability:
Provides a foundation for scalable applications.

# You have Made a Choice CacheNetworkImage Library for image caching :
Choosing cacheNetworkImage offers a strong caching mechanism, allowing local storage of loaded images.
This enhances user experience by minimizing the need to reload images from the network, resulting in quicker load times and reduced data consumption.
Additionally, the library provides offline support,
enabling users to view previously loaded images even without an internet connection.
This is particularly advantageous for applications in scenarios with intermittent or limited network access.

# You Have mMde a Choice Hive Library for Local Storage :
Hive is a fast, and efficient NoSQL database for Flutter that can be easily integrated into your project.


