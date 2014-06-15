class Comment < ActiveRecord::Base
  include Scraper
  after_create :fetch_remote

  #validates_presence_of :body, message: "Ain't got no body.", on: 
  #validates_inclusion_of :proceeding_number, in: ['14-28'],
    #message: "Not neutrality"

  protected

  def fetch_remote
    comment_hash = scrape_comment(id).slice(*valid_keys)
    update(hash_with_formatted_dates(comment_hash))
  end

  def valid_keys
    attribute_names.map { |n| n.to_sym }
  end

  def format_date(datestring)
    Date.strptime(datestring, '%m/%d/%Y') if datestring
  end

  def hash_with_formatted_dates(comment_hash)
    date_received = format_date(comment_hash[:date_received])
    date_posted = format_date(comment_hash[:date_posted])
    comment_hash.merge({
      date_received: date_received,
      date_posted: date_posted
    })
  end

end
