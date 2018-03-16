# wine-app-ios
An application that consume the serli's wine API

## Différence entre class et struct

Both class and structure can do:

* Define properties to store values
* Define methods to provide functionality
* Be extended
* Conform to protocols
* Define intialisers
* Define Subscripts to provide access to their variables

Only class can do:

* Inheritance
* Type casting
* Define deinitialisers
* Allow reference counting for multiple references.

### class

```swift
class SomeClass {
    var name: String
    init(name: String) {
        self.name = name
    }
}

var aClass = SomeClass(name: "Bob")
var bClass = aClass // aClass and bClass now reference the same instance!
bClass.name = "MacGyver"

println(aClass.name) // "MacGyver"
println(bClass.name) // "MacGyver"
```

### struct

```swift
struct SomeClass {
    var name: String
}

var aClass = SomeClass(name: "Bob")
var bClass = aClass // aClass and bClass now reference the same instance!
bClass.name = "MacGyver"

println(aClass.name) // "Bob"
println(bClass.name) // "MacGyver"
```
