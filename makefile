s:	install
	bundle exec jekyll server --host=0.0.0.0 --port 4002

install:
	bundle install

pub:
	git status
	sleep 5
	git add .
	git commit -am 'update'
	git push

port:
	sudo dnf -y install firewalld
	sudo systemctl restart firewalld
	sudo firewall-cmd --permanent --zone=public --add-port=4002/tcp
	sudo firewall-cmd --reload

