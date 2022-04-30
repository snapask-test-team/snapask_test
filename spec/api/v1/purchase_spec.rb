require "rails_helper"

describe V1::Purchase do
  before do 
    @user = FactoryBot.create(:user)
    @category1 = FactoryBot.create(:category)
    @category2 = FactoryBot.create(:category)
    @course1 = FactoryBot.create(:course, category: @category1)
    @course2 = FactoryBot.create(:course, category: @category2)
    @headers = { "Authorization" => @user.gererate_token }
    @params = { pay_information: { type: 1 } }
  end

  context "course is not exist return status 404" do
    it "course is not exist should return 400 status" do
      post "/api/v1/purchase/-1", params: {}, headers: @headers

      expect(response.status).to eq(404)
    end
  end

  context "purchase course success" do
    it "success status" do
      @course1.update(launch: true)
      post "/api/v1/purchase/#{@course1.id}", params: @params, headers: @headers

      expect(response.status).to eq(201)
    end
  end

  context "check user cant't purchase with discontinued course" do
    it "response body should be empty" do 
      @course1.update(launch: false)

      post "/api/v1/purchase/#{@course1.id}", params: @params, headers: @headers

      res_body = JSON.parse(response.body)

      expect(res_body.has_key?("error")).to be(true)
      expect(res_body["error"]["message"]).to eq("Course the course is off the shelves")
    end
  end

  context "check user cant't repeat purchase behavior when user_course record is not expired" do
    it "response body should be empty" do 
      @course1.update(launch: true)
      payment = Payment.new(user: @user, course: @course1, pay_information: { type: 1})
      @result = payment.perform
      if @result
        @user.user_courses.create(course_id: @course1.id, pay_history_id: @result.id, expired_time: @result.pay_time + (@course1.expire_day).days)
      end

      post "/api/v1/purchase/#{@course1.id}", params: @params, headers: @headers

      res_body = JSON.parse(response.body)

      expect(res_body.has_key?("error")).to be(true)
      expect(res_body["error"]["message"]).to eq("User courses the course is not yet expire")
    end
  end

end