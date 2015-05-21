require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class DeployCa < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :install do
        # check key and cert exist
        fail 'CA is missing, can\'t deploy certificate' unless new_resource.ca

        file ::File.join(new_resource.ca_path, new_resource.name + '.crt') do
          owner new_resource.ca_owner
          mode new_resource.ca_mode
          content new_resource.ca
        end
      end

      action :remove do
        file new_resource.ca_path, new_resource.name + '.crt' do
          action :delete
          only_if { File.exist?(new_resource.ca_path, new_resource.name + '.crt') }
        end
      end
    end
  end
end
