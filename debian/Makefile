# To install bundler
GEM_HOME := gems
export GEM_HOME

# To find bundler
PATH := bin:${PATH}

# To make secret .. secret
SECRET_KEY_BASE := $(shell head -c 2048 /dev/urandom | sha512sum | cut -f1 -d" ")
export SECRET_KEY_BASE

build:
	gem2.3 install --bindir=bin --no-rdoc --no-ri bundler
	MAKEFLAGS="" CFLAGS="" bundle install --deployment --without=development test

	bundle exec rake assets:precompile RAILS_ENV=production
	rm -rf vendor/bundle/ruby/*/cache

install:
	cp -a app bin gems public vendor config lib db ${DESTDIR}/var/www/edwig-admin
	cp -a Rakefile config.ru Gemfile Gemfile.lock .bundle ${DESTDIR}/var/www/edwig-admin
	cp debian/database.yml debian/production.rb debian/apache2.conf ${DESTDIR}/etc/edwig-admin/
	install --mode=755 debian/bundle-exec ${DESTDIR}/var/www/edwig-admin/bin

clean:
	rm -rf vendor/bundle
