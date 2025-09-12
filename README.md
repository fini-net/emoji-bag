# emoji-bag

![GitHub Issues](https://img.shields.io/github/issues/fini-net/emoji-bag)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/fini-net/emoji-bag)
![GitHub License](https://img.shields.io/github/license/fini-net/emoji-bag)
![GitHub watchers](https://img.shields.io/github/watchers/fini-net/emoji-bag)

A collection of emojis for your [Zulip](https://zulip.com/) and Slack fun times.

## Contributing

Run `just` to see a full list of `just` subcommands which include our
[development processs](.github/CONTRIBUTING.md#development-process)
and shortcuts for logging into Slack and downloading a current set of
emojis

- [Code of Conduct](.github/CODE_OF_CONDUCT.md)
- [Contributing Guide](.github/CONTRIBUTING.md) includes a step-by-step guide to our
  [development processs](.github/CONTRIBUTING.md#development-process).

```shellsession
% just
just --list
Available recipes:
    [Compliance]
    compliance_check              # our own compliance check

    [Process]
    branch branchname             # start a new branch
    merge                         # merge PR and return to starting point
    pr                            # PR create 3.2
    prweb                         # view PR in web browser
    release rel_version           # make a release
    sync                          # escape from branch, back to starting point

    [Slack Authentication]
    slack_new_workspace workspace # authenticate to a new workspace

    [Slack Download]
    get_slack_brightroll          # download BrightRoll Alumni emoji from Slack
    get_slack_devopschat          # download DevOpsChat emoji from Slack
    get_slack_eng_managers        # download Eng-Managers emoji from Slack
    get_slack_fini                # download FINI emoji from Slack
    get_slack_hangops             # download HangOps emoji from Slack
    get_slack_haproxy             # download Haproxy emoji from Slack
    get_slack_networktocode       # download NetworkToCode emoji from Slack
    get_slack_rands_leadership    # download Rands Leadership emoji from Slack

    [Slack Processing]
    slack_process_zip directory   # turn a zip file into raw files

    [Utility]
    utcdate                       # print UTC date in ISO format

    [example]
    list                          # list recipes (default works without naming it)
Your justfile is waiting for more scripts and snippets
```

## Starting a new workspace

### Authentication

Run `just slack_new_workspace $WORKSPACE_NAME` to get your authentication
tokens downloaded.  This will usually fire something off in your web
browser and it might hit your SSO system.

I'm not sure how long these tokens last, but I have not had to
re-authenticate yet.  So the tokens last for at lesat a few days.
If my interactive Slack experience is any guide these tokens
are good for months.

### Update justfile

Add your new workspace in as a download recipe.  They're very short
snippets like:

```shellsession
# download HangOps emoji from Slack
[group('Slack Download')]
get_slack_hangops:
        just _slack_sync Slack/HangOps hangops
```

So you can see there's not much to change after you do the copy-pasta.

1. Change the workspace name in the recipe name and the `just` line.
2. Update the directory name to be a new one.
3. Make the comment make sense for what you're adding

Done!

### Verify justfile

Run your `just get_slack_$workspace` recipe and make sure you got
the goods without errors.

### Local processing

1. Start a branch with `just branch $branch_name`
2. Run `just slack_process_zip $directory` to extract your ZIP
  file and reformat the JSON so it is human readable.
3. Use `git commit` to get a commit on this branch.
4. Run `just pr` to generate the pull request.
5. Wait for the github actions (less than a minute).
6. Run `just merge` to merge your work.

## Support & Security

- [Getting Support](.github/SUPPORT.md)
- [Security Policy](.github/SECURITY.md)

## Thanks

Thanks to these folks for making this possible:

- [slackdump](https://github.com/rusq/slackdump) works well for me.
- I'm looking forward to trying <https://github.com/rockymadden/slack-cli> soon.
