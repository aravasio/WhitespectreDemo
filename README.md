# WhitespectreDemo
Whitespectre asked me to build a simple app that fetches gifs using the GIPHY web api.

Some of the assumptions I make regarding implementation:

- It fetches gifs from the GIPHY api using the fixed_width_downsampled rendition available, since it seems to be optimized for mobile.
- It uses Cocoapods. Pods folder is already included, so no extra commands are required to build.
- Libraries used are Moya for networking and SDWebImage for straightforward async image fetching from a url-string.
- On the imageView I use aspect fill for the contentMode just because I personally felt it looked better and required no extra effort on my part. Technically we can use custom layouts for each collectionView cell, since the giphy API does provide data on the size of the gif object, but since it was not specified, I did not bother.
- Networking is done using Moya, which allows me to resemble a typified request structure. It allows for safer, clearer and easier to maintain request models and structures.
- The app should be able to, rather easily, scale to also support stickers. Stickers are not implemented, but I figured showing consideration for future-proofing and scalability might be interesting.
- Searching is done in real time. That is, what you type is what you fetch. If you continue typing, you cancel previous requests.
- Pagination is a simple parlor trick; keep on fetching by increasing the offset multiplier and eventually, when responseSize = 0, there’s nothing else to fetch. No support for the GIPHY Pagination object is required.
