# AppDetailsPublishPlugin

## What is this?

This is a plugin for John Sundell's [Publish][publish-github] static site generator, which fetches details for an AppStore app and renders it in a Publish page.


## How do I use it?

In `main.swift`:

```
import AppDetailsPublishPlugin

try MyWebsite()
	.publish(using: [
		.installPlugin(.appDetails())
	])
```

This will use a default `Renderer`. You can make your own renderer by passing it into the `appDetails` function:

```
.installPlugin(.appDetails(MyAppDetailsRenderer())
```

In your `page.md` page, add a blockquote:

```
> appstore 982783760 gb The train app for commuters!
```

The parameters are:

* the App ID for the Apple AppStore
* the region where the app is published. I _think_ this is an [ISO 3166-1 alpha-2][iso-3166-alpha-2-wikipedia] country code.
* an optional subtitle. (While there is a subtitle field in AppStoreConnect, the `https://itunes.apple.com/lookup` API doesn't return the subtitle)

Finally, create a CSS file to style the app details, and add it to your Publish project. You can find an example in [this GitLab Snippet][example-css]. My CSS skills are _awful_ - I'm sure you can do better.


## What does it look ike?

![Example rendered application details](/Docs/example.png)


## Feedback

Merge requests most welcome.


## Author

Matthew Flint, m@tthew.org


## License

_AppDetailsPublishPlugin_ is available under the MIT license. See the LICENSE file for more info.

[publish-github]: https://github.com/johnsundell/publish
[example-css]: https://gitlab.com/mflint/appdetailspublishplugin/-/snippets/2226920
[iso-3166-alpha-2-wikipedia]: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
