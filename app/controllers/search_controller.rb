include Eventful

class SearchController < ApplicationController
  def results
    hash = Hash.new
    params.each do |param|
      hash[param[0]] = param[1]
    end
    @res = Eventful::search_events(hash)
  end
end
