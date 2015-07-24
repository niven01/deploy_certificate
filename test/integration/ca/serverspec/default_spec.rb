# Encoding: utf-8

require_relative 'spec_helper'

describe file('/etc/pki/tls/certs/ca_test_bundle.crt') do
  it { should contain('BEGIN CERTIFICATE') }
end
