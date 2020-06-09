require 'watir'
require 'webdrivers'
require 'csv'

keywords = [
  {'jp': 'サーモン', 'en': "salmon"},
  {'jp': 'マグロ', 'en': "tuna"},
  {'jp': 'さば', 'en': "mackerel"},
  {'jp': 'アジ', 'en': "spanish mackerel"},
  {'jp': 'アナゴ', 'en': "sea eel"},
  {'jp': 'ウナギ', 'en': "eel"},
  {'jp': '卵', 'en': "egg"},
  {'jp': 'いくら', 'en': "salmon roe"},
  {'jp': 'えび', 'en': "shrimp"},
  {'jp': '鯛', 'en': "sea bream"},
  {'jp': 'つぶ貝', 'en': "whelk"},
  {'jp': 'ブリ', 'en': "yellowtail fish"},
  {'jp': 'ホッキ貝', 'en': "surf clam"},
  {'jp': '縁側', 'en': "halibut fin"},
  {'jp': 'たこ', 'en': "octopus"},
  {'jp': 'イカ', 'en': "squid"},
  {'jp': 'ハマチ', 'en': "yellowtail fish"},
  {'jp': 'カンパチ', 'en': "amberjack"},
  {'jp': 'イワシ', 'en': "sardine"},
  {'jp': 'ウニ', 'en': "sea urchin"},
  {'jp': 'ホタテ', 'en': "scallop"},
  {'jp': '赤貝', 'en': "ark clam"},
  {'jp': 'かに', 'en': "crab"},
  {'jp': 'カツオ', 'en': "bonito"},
  {'jp': '小肌', 'en': "shad"},
  {'jp': '大トロ', 'en': "fatty tuna"}
]
# keywords = ['salmon']
scroll_amount = 2

# Initalize the Browser
browser = Watir::Browser.new :chrome, headless: true

keywords.each do |keyword|
  image_urls = []
  # Navigate to Page
  browser.goto "https://images.google.com/?q=#{keyword[:jp]} 寿司"
  browser.button(class: 'Tg7LZd').click

  scroll_amount.times do
    browser.scroll.to :bottom
  end

  images = browser.images(:class => "rg_i")
  images.each do |image|
    image_urls << image.attribute_value("data-src") || image.attribute_value("data-iurl")
  end
  image_urls = image_urls.reject {|url| url. nil?}

  filepath = "csv/#{keyword[:en]}.csv"

  CSV.open(filepath, 'wb') do |csv|
    image_urls.each do |url|
      csv << [url]
    end
  end
end

browser.close

# urls=Array.from(document.querySelectorAll('.rg_i')).map(el=> el.hasAttribute('data-src')?el.getAttribute('data-src'):el.getAttribute('data-iurl'));
# window.open('data:text/csv;charset=utf-8,' + escape(urls.join('\n')));
