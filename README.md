# iOS Assignment CS

My approach to this project was to use MVVM, SwiftUI and Combine. For the networking approach I went with Alex Brown's tutorial on how to make modular networking code with MVVM and Combine. It allows for a really nice abstraction of endpoints, viewmodel, requestbuilder, APIService, and APISession.

## Images

While it is entirely possible to use this same networking approach for downloading images, I went with Kingfisher 5.15.8 (choosing the SwiftUI version in SPM) because it provides built-in support for URLs and image caching. Kingfisher version 6.0 no longer has various choices (UIKit, SwiftUI) and appeared to have bugs.

## Rating view

For the rating view, SwiftUI has built-in support for making a Circle with different trim and stroke settings. I chose not to use the background color in the mock up because it doesn't work as well with dark/light mode.

## Features

Support for dark and light mode.

## Unit and UI Testing

I included a simple sanity network check that seems to indicate code coverage, but it it not comprehensive. I looked into possible approaches for UI testing but I did not have time for this.

## Caveats

The logic for loading extra pages hasn't been heavily tested. I did run into issues at first with decoding errors, so I commented out extra fields in Movie to minimize deocding errors.

Because of respect to time limitations, I just simply loaded up the list from the popular endpoint without loading the details for each movie, which would have allowed display of the runtime.

No progress view for network requests. It would have been nice to put a progress spinner view.

No caching beyond what works automatically with Kingfisher for images and the data that stays until the app is force quit. 

The code for loading the details could be better.

More of the code for the SwiftUI views could be broken down into smaller parts.

The detail view sometimes becomes crowded with the text and poster, especially on smaller screens. It may need to scroll to allow for this.

The list view becomes a little bit crowded on smaller screens. Overall, less hardcoding sizes may help.
