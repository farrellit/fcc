module Scraper
  require 'open-uri'
  PROCEEDING = "14-28"
  INITIAL_VIEW_ID = 6017671861

  def scrape_comment(comment_id)
    view_id = INITIAL_VIEW_ID + comment_id - 1
    comment_hash = Hash.new
    begin
      metadata = get_metadata(view_id)

      document_id = metadata["document_ref"].match(/\d+$/).to_s
      view_url = "http://apps.fcc.gov/ecfs/comment/view?id=#{view_id}"
      document_url = "http://apps.fcc.gov/ecfs/document/view?id=#{document_id}"
      body = get_document_body(document_url)

      values = metadata["text"].map { |t| t["text"].squish }
      keys = metadata["label"].map do |l|
        l["span"].gsub(/[\s|:]/, '').underscore.to_sym
      end
      keys.each_index do |i|
        comment_hash[keys[i]] = values[i]
      end

      comment_hash[:view_id] = view_id
      comment_hash[:document_id] = document_id
      comment_hash[:view_url] = view_url
      comment_hash[:document_url] = document_url
      comment_hash[:body] = body

    rescue
      # handle bad results perhaps
    end

    return comment_hash
  end

  def current_comment_count
    table = get_proceedings_table["table"]
    rows = table.map { |r| r["row"] }
    rows.each do |r|
      if r.try(:first)
        if r[0]["cell"] == PROCEEDING
          return r[2]["cell"]
        end
      end
    end
  end

  private

  def get_metadata(view_id)
    Wombat.crawl do
      base_url "http://apps.fcc.gov/ecfs/comment/view?id=#{view_id}"

      label "css=.wwgrp", :iterator do
        span "css=span"
      end

      text "css=.wwgrp", :iterator do
        text "css=span.text"
      end

      document_ref "css=object"
    end
  end

  def get_document_body(document_url)
    io = open(document_url)
    reader = PDF::Reader.new(io)
    pages = reader.pages.map do |p|
      p.text.squish.sub(/^.+\.txt /, '').sub(/ Page \d+$/, '')
    end

    pages.join(' ')
  end

  def get_proceedings_table
    Wombat.crawl do
      base_url "http://fcc.gov/comments"

      table "css=tr", :iterator do
        row "css=td", :iterator do
          cell "css=a"
        end
      end
    end
  end
end
