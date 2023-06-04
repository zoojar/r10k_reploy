#!/opt/puppetlabs/puppet/bin/ruby
require 'digest'
require 'json'

begin
  dir = '/etc/puppetlabs/code/environments'
  file_info = Dir.glob("#{dir}/**/*.{pp,yaml,yml,rb}", File::FNM_DOTMATCH).reject do |f| 
    File.directory?(f) ||
    f.include?(".git") ||
    f.include?(".r10k-deploy.json")
  end
  .sort
  .map do |f|
    "#{f}:#{File.size(f)}"
  end
  md5 = Digest::MD5.new
  md5.update(file_info.join)
  result = { md5: "#{md5.hexdigest}" } 
  puts(result.to_json)
rescue Puppet::Error => e
  raise e.message
end