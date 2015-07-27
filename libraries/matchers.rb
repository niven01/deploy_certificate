if defined?(ChefSpec)

  def deploy_certificate(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:deploy_certificate, :install, resource_name)
  end

  def remove_certificate(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:deploy_certificate, :remove, resource_name)
  end

end
