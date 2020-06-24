require "uri"

module HtmlCssToImage
  module Data
    class Image
      attr_accessor :url

      def self.from(data)
        raise ArgumentError.new "Key :url does not exist" unless data.key?(:url)

        Image.new(url: data[:url])
      end

      def initialize(url:)
        url = URI(url)

        raise ArgumentError.new "Not https" unless url.scheme == HtmlCssToImage::API_SCHEME
        raise ArgumentError.new "Not HCTI API" unless url.host == HtmlCssToImage::API_HOST

        @url = url
      end

      def id
        url = @url.to_s
        i   = url.rindex('/') + 1

        url[i..-1]
      end
    end
  end
end
