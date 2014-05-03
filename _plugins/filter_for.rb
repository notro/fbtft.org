# Source: https://github.com/bitcoin/bitcoin.org/blob/master/_plugins/filter_for.rb

#filter_for allows to loop in site.pages sorted and filtered
#by custom page variables.

#Example:
#{% filter_for p in site.pages sort_by:date category:release lang:{{page.lang}} %}
#  ..
#{% endfilter_for %}

module Jekyll

  module SortedForImpl
    def render(context)
      sorted_collection = collection_to_sort context
      return if sorted_collection.empty?
      sort_attr = @attributes['sort_by']
      @attributes.delete('sort_by')
      reversed_attr = @attributes['reversed']
      @attributes.delete('reversed')
      limit_attr = @attributes['limit'].to_i
      @attributes.delete('limit')
#puts "\n\n"
#puts @attributes.inspect
#puts "\n\n"
      #filter page by given attributes
      s = []
      for x in sorted_collection
        catch :root do
          @attributes.each do |at,atval|
#print "#{atval} : "
            atval = Liquid::Template.parse(atval).render context
#puts "#{atval}"
#            throw :root unless x.to_liquid.has_key?(at) and x.to_liquid[at] == atval
            throw :root unless x.to_liquid.has_key?(at) and x.to_liquid[at].split(" ").include?(atval)
          end
          s.push(x)
        end
      end
      sorted_collection = s

      #sort collection by given variable
      if sorted_collection.length > 1
        sorted_collection = sorted_collection.sort_by { |i| i.to_liquid[sort_attr] }
        sorted_collection.reverse! if reversed_attr
      end

      # limit collection
      sorted_collection = sorted_collection.slice(0, limit_attr) if limit_attr > 0

      #return modified array
      original_name = @collection_name
      result = nil
      context.stack do
        sorted_collection_name = "#{@collection_name}_sorted".sub('.', '_')
        context[sorted_collection_name] = sorted_collection
        @collection_name = sorted_collection_name
        result = super
        @collection_name = original_name
      end
      result
    end
  end
 
  class SortedForTag < Liquid::For
    include SortedForImpl
 
    def collection_to_sort(context)
      return context[@collection_name].dup
    end
 
    def end_tag
      'endfilter_for'
    end
  end

end
 
Liquid::Template.register_tag('filter_for', Jekyll::SortedForTag)
