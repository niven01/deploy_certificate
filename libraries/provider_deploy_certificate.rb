require 'chef/provider/lwrp_base'

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
        fail 'You have enabled certificate chain but not provided a CA' if new_resource.chain && !new_resource.ca

        # If chain enabled
        if new_resource.chain
          cert_content = "#{new_resource.cert}\n#{new_resource.ca}\n#{new_resource.key}"
        else
          cert_content = new_resource.cert
        end

        file ::File.join(new_resource.cert_path, new_resource.name + '.crt') do
          owner new_resource.cert_owner
          mode new_resource.cert_mode
          content cert_content
          sensitive new_resource.sensitive
        end

        file ::File.join(new_resource.key_path, new_resource.name + '.key') do
          owner new_resource.key_owner
          mode new_resource.key_mode
          content new_resource.key
          sensitive new_resource.sensitive
          not_if { new_resource.chain }
        end
      end

      action :remove do
        file new_resource.cert_path, new_resource.name + '.crt' do
          action :delete
          only_if { File.exist?(new_resource.cert_path, new_resource.name + '.crt') }
        end

        file new_resource.key_path, new_resource.name + '.key' do
          action :delete
          only_if { File.exist?(new_resource.key_path, new_resource.name + '.key') }
        end
      end
    end
  end
end
