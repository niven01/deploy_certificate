require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    class DeployCertificate < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      include Helpers::Subdir
      def whyrun_supported?
        true
      end

      action :install do
        # check key and cert exist
        fail 'Key is missing, can\'t deploy certificate' unless new_resource.key && new_resource.cert
        # check CA name exists if ca provided 
        fail 'You have proved a CA but not a CA name' if new_resource.ca && !new_resource.ca_name
         # check CA provied exists if CA name exists
        fail 'You have proved a CA name but not a CA' if new_resource.ca_name&& !new_resource.ca

        create_subdir(new_resource.cert_path) unless ::File.exist?(new_resource.cert_path)
        create_subdir(new_resource.key_path) unless ::File.exist?(new_resource.key_path)

        file ::File.join(new_resource.cert_path, new_resource.name + '.crt') do
          owner new_resource.cert_owner
          mode new_resource.cert_mode
          content new_resource.cert
          sensitive new_resource.is_sensitive
        end

        if new_resource.ca_name && new_resource.ca
          file ::File.join(new_resource.cert_path, new_resource.ca_name + '_bundle.crt') do
            owner new_resource.cert_owner
            mode new_resource.cert_mode
            content new_resource.ca
            sensitive new_resource.is_sensitive
          end
        end

        file ::File.join(new_resource.key_path, new_resource.name + '.key') do
          owner new_resource.key_owner
          mode new_resource.key_mode
          content new_resource.key
          sensitive new_resource.is_sensitive
        end
      end

      action :remove do
        file ::File.join(new_resource.cert_path, new_resource.name + '.crt') do
          action :delete
          only_if { ::File.exist?(::File.join(new_resource.cert_path, new_resource.name + '.crt')) }
        end

        file ::File.join(new_resource.key_path, new_resource.name + '.key') do
          action :delete
          only_if { ::File.exist?(::File.join(new_resource.key_path, new_resource.name + '.key')) }
        end
      end
    end
  end
end
