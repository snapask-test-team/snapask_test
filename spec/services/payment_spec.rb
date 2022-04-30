require 'rails_helper'

RSpec.describe Payment do
  describe "check payment service object" do
    before do 
      @category = Category.create(name: "Math")
      @course = Course.create(subject: "test course", 
                          price: 100.01,
                          currency: "TWD",
                          url: "http://localhost:3000",
                          description: "Math test course",
                          launch: true, 
                          expire_day: 10,
                          category_id: @category.id
                         )
    
      @user = User.create(email: "test@gmail.com", password: "123456")
    end

    it 'perform success' do
      payment = Payment.new(course: @course, user: @user, pay_information: { type: 1 })
      payment.perform

      expect(payment.present?).to be(true)
    end
    
  end
end
