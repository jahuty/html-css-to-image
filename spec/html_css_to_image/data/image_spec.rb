module HtmlCssToImage
  module Data
    RSpec.describe Image do
      let(:scheme) { HtmlCssToImage::API_SCHEME }
      let(:host)   { HtmlCssToImage::API_HOST }
      let(:url)    { "#{scheme}://#{host}" }

      describe "::from" do
        context "when :url key is missing" do
          it "raises error" do
            expect {
              Image::from({ foo: "bar" })
            }.to raise_error(ArgumentError)
          end
        end

        context "when :url key is present" do
          it "returns image" do
            expect(Image::from({ url: url })).to be_instance_of(Image)
          end
        end
      end

      describe "#initialize" do
        context "when the url is invalid" do
          it "raises error" do
            expect { Image.new(url: "foo") }.to raise_error(ArgumentError)
          end
        end

        context "when the url does not use api's scheme" do
          let(:scheme) { "http" }

          it "raises error" do
            expect { Image.new(url: url) }.to raise_error(ArgumentError)
          end
        end

        context "when the url does not use api's host" do
          let(:host) { "google.com" }
          it "raises error" do
            expect { Image.new(url: url) }.to raise_error(ArgumentError)
          end
        end
      end

      describe "#id" do
        let(:id)  { "bde7d5bf-f7bb-49d9-b931-74e5512b8738" }
        let(:url) { "https://hcti.io/v1/image/#{id}" }

        it "returns uuid" do
          expect(Image.new(url: url).id).to eq(id)
        end
      end
    end
  end
end
