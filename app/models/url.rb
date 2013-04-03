class Url < ActiveRecord::Base
  attr_accessible :link
  before_validation :shorten_url, :include_http

  validates :short_link, presence: true, uniqueness: true
  validates :link, presence: true
  validate :link_is_visitable

  private

  def include_http
    unless self.link.include?('http://')
      self.link = "http://" + self.link
    end

  end

  def shorten_url
    begin
      shorten_url = SecureRandom.hex(3)
      self.short_link = shorten_url
    end while Url.find_by_short_link(shorten_url)
  end

  def link_is_visitable
    # valid_statuses = ['200', '301', '302']
    begin
      Net::HTTP.get_response(URI(self.link))
    rescue
      errors.add(:link, "invalid")
    end
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
