require 'watir'
require 'webdrivers'
require 'csv'

keywords = ['salmon','tuna','saba','aji','anago','unagi','tamago','ikura','ebi','tai','tsubugai','buri','hokkigai','engawa','tako','ika','hamachi','kanpachi','iwashi','uni','hotate','akagai','kani','katsuo','kohada','suunoko','ootoro']
# keywords = ['salmon']

# Initalize the Browser
browser = Watir::Browser.new :chrome, headless: true

keywords.each do |keyword|
  image_urls = []
  # Navigate to Page
  browser.goto "https://images.google.com/?q=#{keyword} sushi"
  browser.button(class: 'Tg7LZd').click
  images = browser.images(:class => "rg_i")
  images.each do |image|
    image_urls << image.attribute_value("data-src") || image.attribute_value("data-iurl")
  end
  image_urls = image_urls.reject {|url| url. nil?}

  filepath = "csv/#{keyword}.csv"

  CSV.open(filepath, 'wb') do |csv|
    image_urls.each do |url|
      csv << [url]
    end
  end
end

browser.close

# urls=Array.from(document.querySelectorAll('.rg_i')).map(el=> el.hasAttribute('data-src')?el.getAttribute('data-src'):el.getAttribute('data-iurl'));
# window.open('data:text/csv;charset=utf-8,' + escape(urls.join('\n')));
