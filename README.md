# System7Components in SwiftUI

## About
- This library contains a collection of UI components that replicate the look & feel of Mac System 7 (1991) in SwiftUI

## 3D Button

###  With Text

```swift
Button("Button with Text") {
    print("Button Pressed")
}
.buttonStyle(System73DButtonStyle(isSymbolButton: false))
```
![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.59.43.png)


### With Symbol

```swift
Button {
    print("Button Pressed")
} label: {
    Label("Demo", systemImage: "star.fill")
        .labelStyle(.iconOnly)
        .padding()
}
.buttonStyle(System73DButtonStyle(isSymbolButton: true))
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2019.00.25.png)

## Alert

```swift
System7AlertWithButtons(title: "The disk could not be erased, because you cannot erase a shared disk", symbol: .stop, buttonConfigurations: [
    System7AlertButtonConfiguration(title: "Cancel", isPrimary: false, action: {
        print("Cancel called")
    }),
    System7AlertButtonConfiguration(title: "OK", isPrimary: true, action: {
        print("OK called")
    })
    
])
```


![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.34.31.png)

## Background

```swift
System7Background(background: .background142)
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.37.20.png)

## Checkbox

```swift
System7Checkbox(title: "Daylight Saving Time", isChecked: $isChecked)
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.36.24.png)

## Divider

```swift
System7Divider()
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.50.14.png)


## FileSymbol

```swift
HStack {
    System7FileSymbol(fileType: .appleMenuItems)
    System7FileSymbol(fileType: .folder(customName: "Folder"))
    System7FileSymbol(fileType: .folder(customName: "Selected Folder"), isSelected: true)
    System7FileSymbol(fileType: .folder(customName: "Open Folder"), isOpen: true)
    System7FileSymbol(fileType: .folder(customName: "Selected and Open Folder"), isSelected: true, isOpen: true)
    System7FileSymbol(fileType: .file(customName: "File"))
    System7FileSymbol(fileType: .custom(customImage: ._16974, customName: "Custom Symbol", width: 30, height: 30))
}
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.39.13.png)

## Frame

```swift
System7Frame(title: "a long text", isFocused: true, scrollbarBehavior: .disabled, onClose: closeCalled) {
    Text("Lorem ipsum dolor sit amet...")
}
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.42.07.png)


## Labeled Content

```swift
System7LabeledContent(title: "Translation Choices Dialog box") {
	//content    
}
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.42.40.png)

## Menu Bar

```swift
let exampleConfiguration = [
    System7MenuItemConfiguration(titleType: .image(image: .Menubar.appleRainbow, width: 12, height: 15), items: []),
    System7MenuItemConfiguration(titleType: .text(title: "File"), items: [
        .button(buttonItem: .init(title: "New Folder", isSelectable: true)),
        .button(buttonItem: .init(title: "Open", isSelectable: true)),
        .button(buttonItem: .init(title: "Print", isSelectable: false)),
        .button(buttonItem: .init(title: "Close Window", isSelectable: true)),
        System7MenuItemType.separator,
        .button(buttonItem: .init(title: "Get Info", isSelectable: true)),
        .button(buttonItem: .init(title: "Sharing...", isSelectable: true))
    ]),
    System7MenuItemConfiguration(titleType: .text(title: "Edit"), items: [])
]
System7MenuBar(menus: exampleConfiguration, onItemClicked: { item in
    print("Item \(item.title) clicked")
})
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.45.04.png)


## Picker

```swift
System7DropDownPicker(
    fallbackTitle: "Select",
    isAnimated: false,
    selection: $selection,
    options: [
        "First",
        "Second",
        "Third",
        "Forth"
    ]
)
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.46.15.png)
![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.46.33.png)

## Primary Button

```swift
Button("OK") {
    print("Pressed")
}
.buttonStyle(System7PrimaryButtonStyle())
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.47.50.png)

## ProgressView

```swift
ProgressView(value: progress)
    .progressViewStyle(System7ProgressViewStyle())
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.43.46.png)

## Radio Button

```swift
System7RadioButtons(items: ["24 hour", "12 hour"], layout: .horizontal, selectedItem: $selectedItem)
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.48.48.png)

## Secondary Button

```swift
Button("Date Formats...") {
    print("Pressed")
}
.buttonStyle(System7ButtonStyle())
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.49.59.png)


## Slider

```swift
System7Slider(value: $value, range: 0.0...100.0)
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.51.50.png)


## Status Bar

```swift
System7StatusBar(leadingText: "9 items", centerText: "813.2 MB in disk", trailingText: "60.3 MB available")
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.52.34.png)

## Textfield

```swift
TextField("My Textfield", text: $text)
    .textFieldStyle(System7TextfieldStyle())
```

![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.55.35.png)


## Typography

### Display
```swift
Text("Display")
    .system7FontDisplay()
```
![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.58.22.png)
### Large
```swift
Text("Large")
    .system7FontLarge()
```
![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.58.39.png)
### Small
```swift
Text("Small")
    .loadCustomFonts()
    .system7FontSmall()
    .system7ScalablePadding()
```
![](readme_assets/Bildschirmfoto%202024-05-03%20um%2018.59.02.png)
