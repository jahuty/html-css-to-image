module HtmlCssToImage
  RSpec.describe Image do
    let(:url) { "#{HtmlCssToImage::API_ORIGIN}/#{HtmlCssToImage::API_VERSION}/image" }

    before do
      HtmlCssToImage.api_key = "foo"
      HtmlCssToImage.user_id = "bar"
    end

    describe "::create" do
      context "when the :html and :css arguments are nil" do
        it "raises error" do
          expect { Image.create }.to raise_error(ArgumentError)
        end
      end

      context "when the API responds without 200 status" do
        before do
          stub_request(:post, url).
            to_return(
              status: 401,
              body: {
                "error": "Unauthorized",
                "statusCode": 401,
                "message": "Missing authentication"
              }.to_json
            )
        end

        it "raises error" do
          expect { Image.create(html: "foo") }.to raise_error(Error)
        end
      end

      context "when the API responds with 200 status" do
        let(:body) { { url: "https://hcti.io/v1/image/bde7d5bf-f7bb-49d9-b931-74e5512b8738" } }

        before { stub_request(:post, url).to_return(status: 200, body: body.to_json) }

        it "returns image" do
          expect(Image.create(html: "foo")).to be_instance_of(Data::Image)
        end
      end
    end

    describe "::delete" do
      context "when id is nil" do
        it "raises error" do
          expect { Image.delete }.to raise_error(ArgumentError)
        end
      end

      context "when the API responds without 202 or 404 status" do
        let(:id) { "foo" }

        before do
          stub_request(:delete, url + "/#{id}").
            to_return(
              status: 401,
              body: {
                "error": "Unauthorized",
                "statusCode": 401,
                "message": "Missing authentication"
              }.to_json
            )
        end

        it "raises error" do
          expect { Image.delete(id) }.to raise_error(Error)
        end
      end

      context "when the API responds with 202 status" do
        let(:id) { "foo" }

        before { stub_request(:delete, url + "/#{id}").to_return(status: 202) }

        it "returns nil" do
          expect(Image.delete(id)).to be_nil
        end
      end
    end
  end
end
