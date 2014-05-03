module Jekyll
  module JSFilter
    def js_strip(input)
      input
    end
  end
end

Liquid::Template.register_filter(Jekyll::JSFilter)
#Liquid::Template.error_mode = :strict
