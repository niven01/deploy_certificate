# Encoding: utf-8

require_relative 'spec_helper'

describe 'deploy_certificate_tests::deploy_ca' do
  before { stub_resources }
  context 'centos' do
    let(:chef_run) do
      ChefSpec::Runner.new(:log_level => LOG_LEVEL, :platform => 'centos', :version => '6.6', :step_into => ['deploy_certificate']) do |node|
         stub_node_resources(node)
      end.converge(described_recipe) 
    end
 
    it 'deploys cert' do
      expect(chef_run).to deploy_certificate('cert_test')
    end

    it 'creates cert /etc/pki/tls/certs/ca_test_bundle.crt' do
      expect(chef_run).to create_file('/etc/pki/tls/certs/ca_test_bundle.crt')
    end

    it 'creates cert /etc/pki/tls/certs/cert_test.crt' do
      expect(chef_run).to create_file('/etc/pki/tls/certs/cert_test.crt')
    end

    it 'creates key /etc/pki/tls/private/cert_test.key' do
      expect(chef_run).to create_file('/etc/pki/tls/private/cert_test.key')
    end

  end
end
