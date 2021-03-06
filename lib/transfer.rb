require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    receiver.valid? && sender.valid?
  end

  def execute_transaction
    if valid? && sender.balance > self.amount && self.status == "pending"
      receiver.balance += self.amount
      sender.balance -= self.amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.execute_transaction
      receiver.balance -= self.amount
      sender.balance += self.amount
      self.status = "reversed"
    end
  end

end
