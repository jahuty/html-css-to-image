RSpec.describe HtmlCssToImage do
  it "has a version number" do
    expect(HtmlCssToImage::VERSION).not_to be nil
  end

  describe "#connection" do
    let(:api_key) { "foo" }
    let(:user_id) { "bar" }

    before do
      HtmlCssToImage.api_key = api_key
      HtmlCssToImage.user_id = user_id
    end

    context "when api_key is not set" do
      let(:api_key) { nil }

      it "raises error" do
        expect { HtmlCssToImage.connection }.to raise_error(RuntimeError)
      end
    end

    context "when user_id is not set" do
      let(:user_id) { nil }

      it "raises error" do
        expect { HtmlCssToImage.connection }.to raise_error(RuntimeError)
      end
    end

    context "when api_key and user_id are set" do
      it "returns connection" do
        expect(HtmlCssToImage.connection).to be_instance_of(Faraday::Connection)
      end

      it "has basic authentication header" do
        expect(HtmlCssToImage.connection.headers).to include("Authorization")
      end

      it "has Content-Type header" do
        expect(HtmlCssToImage.connection.headers).to include("Content-Type")
      end

      it "has Accept header" do
        expect(HtmlCssToImage.connection.headers).to include("Accept")
      end
    end
  end
end
