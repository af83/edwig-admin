task :package do
  release_name = Time.now.strftime('%Y%m%d%H%M%S')

  rm_rf "tmp/package"
  mkdir_p "tmp/package"

  sh "git archive --format=tar --output=tmp/package/edwig-admin-release-#{release_name}.tar HEAD"

  sh "bundle package --all"
  sh "tar -rf tmp/package/edwig-admin-release-#{release_name}.tar vendor/cache"

  # cp "install/apache.conf", "tmp/package/apache.conf"
  # cp "install/deploy.sh", "tmp/package/deploy-helper.sh"
  # cp "config/environments/production.rb", "tmp/package/production.rb"

  sh "tar -czf edwig-admin-#{release_name}.tar.gz -C tmp/package ."
  sh "rm -rf tmp/package vendor/cache"
end
