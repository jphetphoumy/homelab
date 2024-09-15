homelab: tofu_apply jenkins
destroy: tofu_destroy

tofu_init: 
	cd infra/production/runick/; tofu init
tofu_plan: tofu_init
	cd infra/production/runick/; tofu plan -out tofu.plan
tofu_apply: tofu_plan
	cd infra/production/runick/; tofu apply tofu.plan
jenkins:
	cd provisioning; ansible-playbook -i inventory.yml playbooks/jenkins.yml
tofu_destroy: tofu_plan
	cd infra/production/runick/; tofu destroy
