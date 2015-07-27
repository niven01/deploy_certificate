# Encoding: utf-8

require_relative 'spec_helper'

describe 'deploy_certificate_tests::deploy_cert' do
  before { stub_resources }
  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::Runner.new(:log_level => LOG_LEVEL, :platform => 'ubuntu', :version => '14.04', :step_into => ['deploy_certificate']) do |node|
         stub_node_resources(node)
      end.converge(described_recipe) 
    end
 
    it 'deploys cert' do
      expect(chef_run).to deploy_certificate('cert_test')
    end

    it 'creates cert /etc/ssl/certs/cert_test.crt' do
      expect(chef_run).to create_file('/etc/ssl/certs/cert_test.crt')
    end

    it 'creates key /etc/ssl/private/cert_test.key' do
      expect(chef_run).to create_file('/etc/ssl/private/cert_test.key')
    end

  end
end
