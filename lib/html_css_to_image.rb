require "html_css_to_image/version"

require "html_css_to_image/image"
require "html_css_to_image/data/image"

require "faraday"

module HtmlCssToImage
  class Error < StandardError; end

  API_SCHEME   = "https"
  API_HOST     = "hcti.io"
  API_VERSION  = "v1"
  API_ORIGIN   = "#{API_SCHEME}://#{API_HOST}"

  @api_key
  @user_id

  class << self
    attr_writer :api_key, :user_id

    def connection
      raise "API key not set" if @api_key.nil?
      raise "User id not set" if @user_id.nil?

      Faraday.new(API_ORIGIN) do |connection|
        connection.adapter Faraday.default_adapter
        connection.headers["Content-Type"] = "application/json"
        connection.headers["Accept"]       = "application/json"
        connection.basic_auth @user_id, @api_key
      end
    end
  end
end
