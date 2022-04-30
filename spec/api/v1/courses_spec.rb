require "rails_helper"

describe V1::Courses do
  before do 
    @user = FactoryBot.create(:user)
    @category1 = FactoryBot.create(:category)
    @category2 = FactoryBot.create(:category)
    @course1 = FactoryBot.create(:course, category: @category1)
    @course2 = FactoryBot.create(:course, category: @category2)
    @headers = { "Authorization" => @user.gererate_token }
  end

  context "get courses information with user" do
    it "should return 200 status" do
      get "/api/v1/account/courses", params: {}, headers: @headers

      expect(response.status).to eq(200)
    end

    it "response body should be empty" do 
      get "/api/v1/account/courses", params: {}, headers: @headers

      res_body = JSON.parse(response.body)
      expect(res_body).to eq([])
    end
  end

  context "get user purchase courses information" do
    before do
      payment = Payment.new(user: @user, course: @course1, pay_information: { type: 1})
      @result = payment.perform
      if @result
        @user.user_courses.create(course_id: @course1.id, pay_history_id: @result.id, expired_time: @result.pay_time + (@course1.expire_day).days)
      end

      get "/api/v1/account/courses", params: {}, headers: @headers
      @res_body = JSON.parse(response.body)
    end


    it "should return 200 status" do
      expect(@response.status).to eq(200)
    end

    it "response body should have a course information" do 
      expect(@res_body.count).to eq(1)
    end

    it "check course record and pay history is same" do 
      course_record = @res_body.first
      expect(course_record["pay_information"]["total_price"].to_f).to eq(@course1.price.to_f)
    end
  end

  context "filter course information with expired" do
    before do
      payment = Payment.new(user: @user, course: @course1, pay_information: { type: 1})
      @result = payment.perform
      if @result
        @user.user_courses.create(course_id: @course1.id, pay_history_id: @result.id, expired_time: @result.pay_time-3.days)
      end
    end

    it "response body should be empty" do 
      get "/api/v1/account/courses?filter_expire=true", params: {}, headers: @headers

      res_body = JSON.parse(response.body)
      expect(res_body).to eq([])
    end
  end

end