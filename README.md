# HtmlCssToImage

A simple SDK for the [HTML/CSS to Image](https://htmlcsstoimage.com) service (HCTI).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'html_css_to_image'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install html_css_to_image

## Usage

Set your HCTI `api_key` and `user_id`:

```ruby
require "html_css_to_image"

HtmlCssToImage.api_key = "a87d7cca-9d66-47d8-aa2c-66bef8583fc9"
HtmlCssToImage.user_id = "6ee431f7-05e5-43ca-8e28-3160117d29f3"
```

To create an image, pass `html` and/or `css` arguments to the `create` method. The method will return an `HtmlCssToImage::Data::Image` object with `url` and `id` methods:

```ruby
html = "<h1>Hello world</h1>"
css  = "h1 { color: red; }"

image = HtmlCssToImage.create(html: html, css: css)

image.url  
# => "https://hcti.io/v1/image/bde7d5bf-f7bb-49d9-b931-74e5512b8738"
image.id
# => "bde7d5bf-f7bb-49d9-b931-74e5512b8738"
```

If the API returns any status code except `201`, a `HtmlCssToImage::Error` will be raised with more information about the error.

To delete an image, pass the image's `id` to the `delete` method:

```ruby
id = "bde7d5bf-f7bb-49d9-b931-74e5512b8738"

HtmlCssToImage.delete(id)
```

If the API returns any status code except `202` or `404`, a `HtmlCssToImage::Error` will be raised with more information about the error.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `tspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle install`. To release a new version, update the version number in `version.rb`, and then run `bundle release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/jahuty/html_css_to_image). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HtmlCssToImage project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/html_css_to_image/blob/master/CODE_OF_CONDUCT.md).
