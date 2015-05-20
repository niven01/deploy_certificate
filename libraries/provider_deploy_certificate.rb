require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    class DeployCertificate < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :install do
        # check key and cert exist
        fail 'Key is missing, can\'t deploy certificate' unless new_resource.key && new_resource.cert

        file ::File.join(new_resource.cert_path, new_resource.name + '.crt') do
          owner 'root'
          mode '0644'
          content new_resource.cert
        end

        file ::File.join(new_resource.key_path, new_resource.name + '.key') do
          owner 'root'
          mode '0600'
          content new_resource.key
        end
      end
    end
  end
end
