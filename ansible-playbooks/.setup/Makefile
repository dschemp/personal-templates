provision:
	ansible-playbook playbook.yml --ask-become-pass --ask-pass

systeminfo:
	ansible all -m setup --ask-pass

lint:
	pre-commit run --all-files

check:
	yamllint .
