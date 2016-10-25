class Clickbait < ActiveModel::Validator
  CLICKBAIT=["Won't Believe", "Secret", "Top
  #{/([0-9])/}", "Guess"]

  def validate(record)
    answer = false
    CLICKBAIT.each do |bait|
      answer = record.title.to_s.include?(bait)
      break if answer
    end
    record.errors[:clickbait] << "Not Clickbait!" unless answer
    # binding.pry
    answer
  end
end

class Post < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with Clickbait
  validates :title, presence: true
  validates :content, length: {minimum:250}
  validates :summary, length: {maximum:250}
  validates :category, inclusion:{in:%w(Fiction Non-Fiction)}

end
