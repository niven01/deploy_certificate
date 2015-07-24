# Encoding: utf-8

require_relative 'spec_helper'

describe file('/etc/pki/tls/certs/cert_test_combined.crt') do
  it { should contain('BEGIN CERTIFICATE') }
end
