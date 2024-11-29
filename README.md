# GitHub User Finder App

This is a simple iOS application built with **Swift 5** and **SwiftUI**, designed to search GitHub users and display relevant user details. The app uses a **MVVM architecture** to manage the separation of concerns and maintainable code. The app interacts with the **GitHub API** for user data fetching and displays it in a clean and responsive UI.

## Features

- Search GitHub users by username.
- Displays user details like name, username, avatar, bio, followers, repositories, etc.
- Keeps a history of recent searches stored in **UserDefaults**.
- Built using **Swift 5** and **Xcode 16**.
- Deployment target: **iOS 16**.

## Architecture

The application follows the **MVVM (Model-View-ViewModel)** pattern, ensuring a clean separation between UI and business logic. The `ViewModel` handles the transformation of the model data into a format that can be displayed by the `View`. 

- **Model**: Represents the structure of the user data fetched from the GitHub API.
- **View**: Responsible for displaying the data to the user using **SwiftUI** components.
- **ViewModel**: Contains the logic to fetch and format the data from the model and passes it to the view.

### Factory Pattern

A **Factory Pattern** is used for creating the `ViewModel` and `View`. This pattern was introduced to centralize the creation of objects and make the code more maintainable and extensible. By using this approach, we can easily create new views or view models without worrying about the internal dependencies. It also helps keep the codebase more modular and testable.

While implementing **MVVM-C** (MVVM with Coordinator pattern) would be a good choice for handling navigation in larger apps, this app is simple and small, so I decided not to use it. However, the architecture can easily be extended with a **Coordinator** to improve navigation flow in the future.

### No Third-Party Libraries

No third-party libraries were used in the project, as they were not needed. By keeping the app dependency-free, we ensure that it remains lightweight and easier to maintain. Additionally, it avoids adding unnecessary complexity to the project.

## Network Calls

- **Async/Await**: The network calls are handled using **async/await** to provide a modern, efficient, and easy-to-understand way to make asynchronous calls. This also enhances code readability and error handling.

## Persistence

The **search history** is saved in **UserDefaults**. When a user searches for a GitHub user, the search term is added to the history, which is loaded every time the app starts. This feature enhances the user experience by allowing quick access to previous searches.

## SOLID Principles

I followed the **SOLID principles** of object-oriented design, ensuring that the code remains modular, maintainable, and flexible. While the current code adheres to SOLID principles, there is still room for improvement, especially as the app evolves.

## Testing

Unit tests were written to verify the functionality of the app, focusing on the business logic and network calls. I also utilized **Combine** in some of the tests to demonstrate its use in handling asynchronous data streams and managing state updates. Due to time constraints, not all edge cases were covered, but the core functionality has been tested. With more time, additional test cases can be added to improve test coverage.

## Future Improvements

- Implement **MVVM-C** for easier navigation management in the future.
- Expand **unit tests** to cover more scenarios.
- Improve error handling and user feedback during network calls.
- Optimize the UI for different screen sizes and device orientations.

## Installation

Clone the repository and open the `.xcodeproj` file in **Xcode 16**. Ensure that your deployment target is set to **iOS 16** or higher.

```bash
git clone https://github.com/yourusername/Github-User-Finder.git
cd Github-User-Finder
open Github-User-Finder.xcodeproj
