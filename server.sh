#!/bin/bash
NUM1="1"
OPERATOR="+"
NUM2="1"

EXPECTED_RESULT="2"

# Construct the expression
EXPRESSION="$NUM1$OPERATOR$NUM2"
ACTUAL_RESULT=$(echo "$EXPRESSION" | bc)

# Check if result matches expected output
if [[ "$ACTUAL_RESULT" == "$EXPECTED_RESULT" ]]; then
    echo "Test Passed: $EXPRESSION = $ACTUAL_RESULT"
else
    echo "Test Failed: Actual result: $ACTUAL_RESULT, Expected: $EXPECTED_RESULT"
fi
 