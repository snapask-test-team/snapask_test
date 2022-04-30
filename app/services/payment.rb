class Payment
  
  def initialize(params = {})
    @course = params.delete(:course)
    @user = params.delete(:user)
    @pay_info = params.delete(:pay_information)
  end

  def perform
    #presume payment reult always success than return true
    if paying
      pay_history = PayHistory.create(
                                      total_price: @course.price,
                                      currency: @course.currency,
                                      pay_type: @pay_info[:type],
                                      pay_time: Time.now
                                    )
      
      pay_history
    else
      return false
    end
  end

  private

  def paying
    return true
  end

end