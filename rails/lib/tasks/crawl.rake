namespace :fcc do
  desc "Crawl and scrape stuff from fcc.gov"

  task :comments => :environment do
    include Scraper
    count =
      begin
        current_comment_count.to_i
      rescue
        115205
      end
    puts "fcc comment count: #{count}"

    for c in 1..count
      puts "#{c} of #{count}..."
      Comment.find_or_create_by!(id: c)
    end
  end
end
