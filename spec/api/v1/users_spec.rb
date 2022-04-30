require "rails_helper"

describe V1::Users do

  context "without request body" do
    it "should return 404 status without params" do
      post "/api/v1/user_login"

      expect(response.status).to eq(404)
    end
  end

  context "user email or password is error" do
    user = FactoryBot.create(:user)

    before do 
      post "/api/v1/login", params:
      {
        email: user.email,
        password: "12345"
      }
    end

    it "should return 400 status" do
      expect(response.status).to eq(400)
    end

    it "should return error message" do
      res_body = JSON.parse(response.body)
      expect(res_body["error"].any?).to be(true)
      expect(res_body["error"]["message"]).to eq("Email or Password is falied")
    end
  end

  context "login success and get token" do
    user = FactoryBot.create(:user)

    before do 
      post "/api/v1/login", params:
      {
        email: user.email,
        password: "123456"
      }
    end

    it "should return 201 status" do
      expect(response.status).to eq(201)
    end

    it "should return token" do
      res_body = JSON.parse(response.body)
      expect(res_body.has_key?("token")).to be(true)
    end
  end

end