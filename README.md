
# Jim :muscle:
### Your PT in your pocket and on your wrist


### Purpose

I had the idea for Jim in 2012 when first starting iOS development and my Software Engineering degree. I used it to learn the basics of programming, Obj-C and Cocoa Touch.

What with Uni and work, it kind of got left behind, but now I've started working out again, so I need something to store my workouts in, and I can't find anything in the App Store I 100% like. 

It's kind of going to be a pet project of mine, which I'll use to practice different approaches, techniques, frameworks etc.

Ultimately I'm just making this for myself, but if other people like it, I may launch it on the App Store.

### Contributing

Contributors and feedback welcome :smile:.

#### Parse

At the moment, you won't be able to build Jim with it pointing at its Parse database. This is because Jim's Parse app is still in development mode, which allows greater control over the database using the App ID and Client Key, while I make changes to the schema. When the schema becomes a bit more stable, I'll add the keys to the repo.

For now, at least, you'll have to make a file called `ParseKeys.swift` and put it in the `/Jim/` directory. Xcode will know to find it there. The contents of the file should look like this:

```swift
struct ParseKeys {
    static let appID = "__YOUR_PARSE_APP_ID__"
    static let clientKey = "__YOUR_PARSE_CLIENT_KEY__"
}
```

You'll then need to make an app in [Parse](http://parse.com) and add the App ID and Client Key to the `ParseKeys` struct.

### Features (WIP)

- Native :watch: app for tracking workouts in the gym without having to carry around your phone
- Progress photo tracker
- Weigth tracker
- got more to add from my notes, will do later
