#!/bin/bash

test_dir="$(pwd)/.github/actions/testing"

function cleanup {
	rm -rf "$test_dir"
}

# Register the cleanup function to run on exit or interrupt
trap cleanup EXIT INT

# Create a folder and copy action.yml to it
mkdir -p "$test_dir"
cp action.yml "$test_dir"

# run act and exit with the same error code
if ! act workflow_dispatch -W test_action_workflow.yml -s LAGON_API_TOKEN="$LAGON_API_TOKEN"; then
	exit $?
fi

# Clean up the test directory
cleanup
