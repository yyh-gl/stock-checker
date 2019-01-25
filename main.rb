# coding: utf-8

require 'nokogiri'
require 'open-uri'
require 'dotenv/load'
require 'slack-notifier'

CHARSET = 'utf-8'
URL = ENV['TARGET_URL']

def setup_doc(url)
  html = open(url) { |f| f.read }
  doc = Nokogiri::HTML.parse(html, nil, CHARSET)
  doc.search('br').each { |n| n.replace("\n") }
  doc
end

def can_buy?(doc)
  doc.xpath("/html/body/div[@id='body']/div[@id='wrapper']/section[@id='contents']/section[@id='main']/section[@id='storeDetailAera']/div[@id='storeDetailTextArea']/div[@id='storeDetailPrice']/div[@class='sotoreDetailForm']/form/div[@class='storeDetailForm']/select/option[@value='0:TQ==']").text.size == 1
end

def send_message(message)
  slack_notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL'])
  slack_notifier.ping(message)
end

doc = setup_doc(URL)
send_message("入荷した！\n#{URL}") if can_buy?(doc)

