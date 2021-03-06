module CacheHelper
  def cache(file, opts = {})
    options = {:url => File.join(@spec_root,'data',file), :cache_dir => @cache}.merge(opts)
    cacher = @klass.new(options)
    cacher.cache
  end

  def exists?(file)
    f = File.join(@cache,file)
    File.should be_exists(f)
    File.should be_file(f)
  end
  
  def does_not_exist?(file)
    f = File.join(@cache,file)
    File.should_not be_exists(f)
  end

  def cache_size
    Dir.glob(@cache + "/**/*").select{|f| File.file?(f) }.size
  end
end

require 'openssl'
module OpenSSL
  module SSL
	  remove_const :VERIFY_PEER
	end
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE