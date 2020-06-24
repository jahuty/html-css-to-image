module HtmlCssToImage
  class Image
    class << self
      def create(html: nil, css: nil)
        raise ArgumentError.new "HTML and CSS are both nil"  if html.nil? && css.nil?

        response = connection.post(resources) do |request|
          request.body = { html: html.to_s, css: css.to_s }.to_json
        end

        raise Error.new(
          "Failed to create image: #{response.status} #{response.body} "
        ) if response.status != 201

        json = JSON.parse(response.body, symbolize_names: true)

        Data::Image.from(json)
      end

      def delete(id)
        raise ArgumentError.new "id is nil" if id.nil?

        response = connection.delete(resource(id))

        raise Error.new(
          "Failed to delete image #{id}: #{response.status} #{response.body}"
        ) unless [202, 404].include? response.status
      end

      private

      def connection
        @connection ||= HtmlCssToImage.connection
      end

      private

      def resources
        "#{HtmlCssToImage::API_VERSION}/image"
      end

      def resource(id)
         "/#{resources}/#{id}"
      end
    end
  end
end
