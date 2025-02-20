#!/bin/bash -xe

# Below command can be replaced to the required CLI, including with custom JSON output, assuming the NextToken is in the same location.
AWS_CLI_COMMAND="aws cloudtrail lookup-events --region us-east-1 --max-items 100 --lookup-attributes AttributeKey=EventName,AttributeValue=Decrypt"
OUTPUT_FILE="./output-$(date +%s)"

function CLI_call() {
  if [ -z $NEXT_TOKEN ]; then
    cli_output=$($AWS_CLI_COMMAND)
  else
    cli_output=$($AWS_CLI_COMMAND --starting-token $NEXT_TOKEN)
  fi

  echo $cli_output >> $OUTPUT_FILE
  echo $cli_output | jq -r ".NextToken"
}

while [ "$NEXT_TOKEN" != "null" ]; do
  NEXT_TOKEN=$(CLI_call $NEXT_TOKEN)
done
