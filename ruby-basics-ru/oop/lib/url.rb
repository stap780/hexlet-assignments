# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  extend Forwardable
  include Comparable
  attr_accessor :url
  def_delegators :@url, :scheme, :host, :port

  def initialize(url)
    @url = URI(url)
  end

  def scheme
    @url.scheme
  end

  def host
    @url.host
  end

  def port
    @url.port
  end

  def query_params
    return {} if @url.query.nil?
    ary = URI.decode_www_form(@url.query)
    b = ary.map{|(k,v)| [k.to_sym,v]}
    Hash[b]
  end

  def query_param(key,value = nil)
    query_params.key?(key) ? query_params[key] : value
  end

  def <=>(other)
    self.url_as_string <=> other.url_as_string
  end

  def url_as_string
    [scheme, host, port, sorted_params].join
  end

  private

  def sorted_params
    sorted_params = query_params.sort.to_h
    sorted_params.map { |k, v| "#{k}=#{v}" }.join('&')
  end

end
# END
