# Slack Bot

Everything in the scheduled directory will be sent once, after the specific time. It's as easy as composing the json and dumping it in the folder.

## Importing Messages from an Excel Sheet

1. Clone this repository!
2. `cd` into this directory
3. Download the Automated Messages spreadsheet in **XLSX FORMAT**
4. `pip install openpyxl`
4. Run with `--dry-run` to preview the output `python extra/spreadsheet2slack.py ~/Downloads/Automated\ Slack\ Messages.xlsx --dry-run | less`
5. Run without `--dry-run` to write the files `python extra/spreadsheet2slack.py ~/Downloads/Automated\ Slack\ Messages.xlsx`
6. `git add scheduled; git commit -m "Add new messages"; git push`

### Updating Excel Messages

- Uncheck "processed"
- Run the script
- be careful? (they include a bit of the text so if you edit the start of the message it may generate a duplicate file, watch out.)

## Editing the template

1. You can use [this page](https://app.slack.com/block-kit-builder/T01EGPWTHFF) to edit and create the custom templates you might want to send.
2. This command can help previewing the message you're going to send:

   ```bash
   xdg-open "$(cat extra/shift-change-gtn.json | jq -c | sed 's|^|https://app.slack.com/block-kit-builder/T01EGPWTHFF\#|g')"
   ```


## Rebuilding the shift-change messages

Since these are relatively automated, you can run `./build.sh` to rebuild the shift-change messages. These are templated out from the [./shift-change-template.json](shift-change-template.json) file (only the header really.) This only needs to be done once really, after that if you want any customisations (e.g. for friday, you can do that in the scheduled directory)

## CRON

There is a script, ./cron.sh that is meant to run on cron. It will send messages which are older than "now" (so run it at 5 min past the hour?) and log them so it doesn't send them again.

```
5 * * * * cd /this/directory && SLACK_URL="https://hooks.slack.com/services/T01.../B01.../uUK.." bash cron.sh
```

