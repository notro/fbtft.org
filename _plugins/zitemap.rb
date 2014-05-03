# need to be the last plugin so we get all the pages
require 'open-uri'

require 'pp'

module Jekyll
  class SitemapPage < Page
    def initialize(site)
      @site = site
      @base = site.source
      @dir = '.'
      @name = 'sitemap.html'
      @data = {'layout' => 'default', 'title' => 'Sitemap'}

      self.process(@name)


# sort by url
# skip outsiders
      pages = site.pages.clone
      pages.reject! { |p| URI(p.url).scheme }
      pages.sort! { |a,b| a.url <=> b.url }


      self.content = "<ul>\n"
      for page in pages
        self.content << "<li>#{page.url}--<a href=\"#{page.url}\">#{page.data['title']}</a></li>\n"
      end
      self.content << "</ul>\n"
    end
  end

  class SitemapPageGenerator < Generator
    safe true

    def generate(site)
      site.pages << SitemapPage.new(site)
    end
  end

end
