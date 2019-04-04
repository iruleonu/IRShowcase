# Showcase

Showcase of a native app fetching random posts list and the full post details (with comments) after clicking on a specific post. 
Feed data is grabbed from [here](http://jsonplaceholder.typicode.com/posts).

* Persists the posts, poster details and comments for availability when using the app without network
* ReactiveSwift, MVVM, coordinators
* State structure inspired by Redux [Three Principles](https://redux.js.org/introduction/three-principles#three-principles) concept
* AsyncDisplayKit for performance
* Unit tests and snapshot tests

## Uses

* Swift
* CoreData
* AsyncDisplayKit/Texture
* ReactiveSwift
* Nimble
* Quick
* SwiftyMocky
* ios-snapshot-test-case
* SwiftLint

## Getting started

### [Carthage](https://github.com/Carthage/Carthage#installing-carthage):

```
carthage bootstrap --platform ios --use-ssh --new-resolver --cache-builds
```

### [Swiftlint](https://github.com/realm/SwiftLint#installation):

Using Homebrew:
```
brew install swiftlint
```

### To run unit tests: [SwiftyMocky](https://github.com/MakeAWishFoundation/SwiftyMocky/blob/develop/guides/Installation.md#2-carthage):
Run the script get_sourcery.sh on the root of the project

```
chmod +x get_sourcery.sh
./get_sourcery.sh
```
