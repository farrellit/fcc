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
      begin
        Comment.find_or_create_by!(id: c)
      rescue
        puts "invalid or something"
      end
    end
  end

  desc "Remove empty comments"
  task :purge => :environment do
    Comment.where("body is null").delete_all
  end
end
