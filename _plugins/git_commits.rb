#require 'rubygems'
require 'http'
require 'date'

require 'pp'

module Jekyll

  class CommitPage < Page
    def initialize(site, base, dir, commit, category)
      @site = site
      @base = base
      @dir = dir
      @data = {}

      self.data['category'] = "news #{category}"

      message = commit['commit']['message'].split("\n", 2)
      self.data['title'] = message.first
      if message.count == 1
        self.content = nil
      else
        self.content = "<pre>#{message.last}</pre>"
      end
      self.data['date'] = DateTime.parse(commit['commit']['committer']['date'])
      self.data['author'] = commit['commit']['committer']['name']

      # commit content override?
      override = site.data['commit_override'].detect { |c| c['commit'] == commit['sha'] }
      if override
#      puts "we have a match"
#      pp override
        self.content = "<pre>#{override['content']}</pre>"
      end

      @url = commit['html_url']
      @name = File.basename "#{@url}.html"
      self.process(@name)
    end

    def write(dest)
      # don't write this since the url points to the actual commit
    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      return unless site.config['github'] and site.config['github']['commits']

      # find if any news pages has commit override
      overrides = []
      for page in site.pages
        overrides << page.data['commit'] if page.data['commit']
      end

      for repo in site.config['github']['commits']
        url = repo['url']
        raise "missing url" unless repo['url']
        category = repo['category']
        Jekyll.logger.debug "CommitPage:", "Processing #{url}"
        r = Http.get "#{url}?per_page=100"
        if r.nil?
          raise "could not get ${url}"
        end
        if r['X-RateLimit-Remaining'] == "0"
          raise "Github API rate limit exceeded (#{r['X-RateLimit-Limit']} per hour)"
        end

        j = JSON.parse r.to_s
        for commit in j
          unless commit.respond_to? 'has_key?'
          Jekyll.logger.error "CommitPage:", j.inspect
          raise "bad response from #{url}"
      end

#pp commit

          page = CommitPage.new(site, site.source, 'news', commit, category)
          site.pages << page
        end
      end
    end
  end

end
