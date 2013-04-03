class Url < ActiveRecord::Base
  attr_accessible :link
  before_validation :shorten_url

  validates :short_link, presence: true, uniqueness: true

  private

  def shorten_url
    begin
      shorten_url = SecureRandom.hex(3)
      self.short_link = shorten_url
    end while Url.find_by_short_link(shorten_url)
  end


  # def shorten_url
  #   shorten_url = "aaa" #SecureRandom.hex(3)
  #   if Url.find_by_short_link(shorten_url)
  #     puts "if this short link has been generated before"
  #     self.shorten_url #doesn't work if we make this a private method
  #   else
  #     puts "if no such short link exists"
  #     self.short_link = shorten_url
  #   end
  # end  
end
