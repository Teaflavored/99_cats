class Cat < ActiveRecord::Base
  SEX = ["M", "F"]
  COLOR = ["black", "brown", "gray", "white", "chocolate", "calico", "tortie"]
  validates :sex, presence: true, inclusion: { in: SEX }
  validates :color, presence: true, inclusion: { in: COLOR }
  validates :birth_date, presence: true
  validates :name, presence: true
  validate :on_or_before_today

  def on_or_before_today
    if !self.birth_date.nil? && self.birth_date > Date.today 
      errors[:birth_date] << "is invalid"
    end
  end
  
  def age
    (Date.today - self.birth_date).numerator/365
  end
end
