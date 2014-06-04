require 'faraday'
require 'json'

module Eventful

  APP_KEY = '&app_key=ZQK7nmvVSbgZDthL'

  API_URL = 'http://api.eventful.com/json'

  GET_METHOD = '/events/get?id='
  SEARCH_METHOD = '/events/search?'

  def get_event (event_id)
    res = Faraday.get(API_URL + GET_METHOD + event_id + APP_KEY).body
    JSON.parse(res)
  end

  module_function :get_event

  def search_events (params = {})
    query = API_URL + SEARCH_METHOD
    params.each do |param|
      if params.first.eql? param
        query += param[0] + '=' + param[1]
      else
        query += '&' + param[0] + '=' + param[1]
      end
    end
    query += APP_KEY
    res = JSON.parse(Faraday.get(query).body)
    res['events']['event']
  end
end
