homelab: tofu_apply jenkins dns traefik gitea 
destroy: tofu_destroy

tofu_init: 
	cd infra/production/jenkins/; tofu init
	cd infra/production/dns/; tofu init
	cd infra/production/gitea/; tofu init
	cd infra/production/traefik/; tofu init
tofu_plan: tofu_init
	cd infra/production/jenkins/; tofu plan -out tofu.plan
	cd infra/production/dns/; tofu plan -out tofu.plan
	cd infra/production/gitea/; tofu plan -out tofu.plan
	cd infra/production/traefik/; tofu plan -out tofu.plan
tofu_apply: tofu_plan
	cd infra/production/jenkins/; tofu apply tofu.plan
	cd infra/production/dns/; tofu apply tofu.plan
	cd infra/production/gitea/; tofu apply tofu.plan
	cd infra/production/traefik/; tofu apply tofu.plan
jenkins:
	cd provisioning; ansible-playbook -i inventory.yml playbooks/jenkins.yml -u root
dns:
	cd provisioning; ansible-playbook -i inventory.yml playbooks/dns.yml -u root
traefik:
	cd provisioning; ansible-playbook -i inventory.yml playbooks/traefik.yml -u root
gitea:
	cd provisioning; ansible-playbook -i inventory.yml playbooks/gitea.yml -u root
tofu_destroy: tofu_plan
	cd infra/production/jenkins/; tofu destroy -auto-approve
	cd infra/production/dns/; tofu destroy -auto-approve
	cd infra/production/gitea/; tofu destroy -auto-approve
	cd infra/production/traefik/; tofu destroy -auto-approve
