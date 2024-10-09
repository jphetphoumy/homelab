homelab: tofu_apply jenkins dns traefik gitea 
destroy: tofu_destroy

tofu_init: 
	cd infra/production/jenkins/; tofu init
tofu_plan: tofu_init
	cd infra/production/jenkins/; tofu plan -out tofu.plan
tofu_apply: tofu_plan
	cd infra/production/jenkins/; tofu apply tofu.plan
jenkins:
	cd provisioning; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.yml jenkins.yml -u root --ask-vault-password
tofu_destroy: tofu_plan
	cd infra/production/jenkins/; tofu destroy -auto-approve
