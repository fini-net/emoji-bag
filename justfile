# project justfile

import? '.just/compliance.just'
import? '.just/gh-process.just'

# list recipes (default works without naming it)
[group('example')]
list:
	just --list
	@echo "{{GREEN}}Your justfile is waiting for more scripts and snippets{{NORMAL}}"

# internal function to sync Slack emojis into this repo
[group('Slack')]
_slack_sync dir workspace:
	[[ -d {{ dir }} ]] || mkdir -p {{ dir }}
	cd {{ dir }} && slackdump emoji -workspace {{ workspace }}

# authenticate to a new workspace
[group('Slack Authentication')]
slack_new_workspace workspace:
	slackdump workspace new {{ workspace }}

# turn a zip file into raw files
[group('Slack Processing')]
slack_process_zip directory: _on_a_branch
	cd {{ directory }} && unzip $(ls -tr *.zip | tail -1)
	cd {{ directory }} && cat index.json | jq '.' > jq.json && mv jq.json index.json
	# no README generated for now
	git add {{ directory }}

# download BrightRoll Alumni emoji from Slack
[group('Slack Download')]
get_slack_brightroll:
	just _slack_sync Slack/BrightRoll brightrollers

# download DevOpsChat emoji from Slack
[group('Slack Download')]
get_slack_devopschat:
	just _slack_sync Slack/DevOpsChat devopschat

# download Eng-Managers emoji from Slack
[group('Slack Download')]
get_slack_eng_managers:
	just _slack_sync Slack/Eng-Managers eng-managers

# download FINI emoji from Slack
[group('Slack Download')]
get_slack_fini:
	just _slack_sync Slack/FINI fininet

# download HangOps emoji from Slack
[group('Slack Download')]
get_slack_hangops:
	just _slack_sync Slack/HangOps hangops

# download Haproxy emoji from Slack
[group('Slack Download')]
get_slack_haproxy:
	just _slack_sync Slack/Haproxy haproxy

# download Rands Leadership emoji from Slack
[group('Slack Download')]
get_slack_rands_leadership:
	just _slack_sync Slack/RandsLeadership rands-leadership

# download NetworkToCode emoji from Slack
[group('Slack Download')]
get_slack_networktocode:
	just _slack_sync Slack/NetworkToCode networktocode
