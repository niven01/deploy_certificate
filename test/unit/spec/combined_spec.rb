# Encoding: utf-8

require_relative 'spec_helper'

describe 'deploy_certificate_tests::deploy_combined' do
  before { stub_resources }
  describe 'ubuntu' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'deploys cert /etc/pki/tls/certs/cert_test._combined.crt' do
      expect(chef_run).to deploy_certificate('cert_test')
    end
  end
end
