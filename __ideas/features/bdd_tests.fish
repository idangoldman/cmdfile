function run_tests_from_file --description 'Run BDD tests from a file for any function'
    set --local testfile $argv[1]

    set --local func_name
    set --local arguments
    set --local expected

    for line in (cat $testfile)
        switch $line
            case 'Given*'
                # Extract the function name and its arguments
                set func_name (string match -r 'function (\w+)' $line)[2]
                set arguments (string match -r '[0-9]+' $line)
            case 'Then*'
                # Extract the expected outcome
                set expected (string match -r '[0-9]+' $line)[1]
                # Dynamically call the function with arguments
                set --local result ($func_name $arguments)
                if test $result -eq $expected
                    echo "Test Passed: Given the function $func_name with arguments $arguments, expected $expected, got $result"
                else
                    echo "Test Failed: Given the function $func_name with arguments $arguments, expected $expected, got $result"
                end
                # Reset for the next test case
                set --erase func_name
                set --erase arguments
                set --erase expected
            case '*'
                # Skip lines that are not 'Given' or 'Then'
        end
    end
end


function run_bdd_tests --description 'Run BDD tests from a file'
    set --local testfile $argv[1]
    set --local current_scenario
    set --local command_to_run
    set --local expected_output

    for line in (cat $testfile)
        switch $line
            case 'Scenario:*'
                set current_scenario (string trim (string replace "Scenario: " "" $line))
            case 'Given*' 'And*'
                # This is where you'd set up preconditions or build the command based on the description.
            case 'When*'
                set command_to_run (string trim (string replace "When we run \"" "" (string replace "\"" "" $line)))
            case 'Then*'
                set expected_output (string trim (string replace "Then the output should include \"" "" (string replace "\"" "" $line)))
                # Here, execute the command_to_run and capture the output for comparison.
                set --local actual_output (eval $command_to_run)
                if string match -q "*$expected_output*" $actual_output
                    echo "Test Passed: $current_scenario"
                else
                    echo "Test Failed: $current_scenario. Expected '$expected_output', got '$actual_output'"
                end
                # Reset for the next scenario
                set --erase command_to_run
                set --erase expected_output
            case '*'
                # Ignore empty lines or comments
        end
    end
end


function run_scenario --description 'Run a single test scenario'
    set --local scenario_description $argv[1]
    set --local command_to_run $argv[2]
    set --local expected_output $argv[3]

    echo "Running scenario: $scenario_description"
    set --local actual_output (eval $command_to_run)

    if string match -q "*$expected_output*" $actual_output
        echo "Test Passed: $scenario_description"
    else
        echo "Test Failed: $scenario_description. Expected '$expected_output', got '$actual_output'"
    end
end

function run_bdd_tests --description 'Run BDD tests from a file, separating scenarios'
    set --local testfile $argv[1]
    set --local scenario_description
    set --local command_to_run
    set --local expected_output

    for line in (cat $testfile)
        switch $line
            case 'Scenario:*'
                if set --query command_to_run
                    run_scenario "$scenario_description" "$command_to_run" "$expected_output"
                    set --erase scenario_description
                    set --erase command_to_run
                    set --erase expected_output
                end
                set scenario_description (string trim (string replace "Scenario: " "" $line))
            case 'Given*' 'And*'
                # Setup or command build logic here.
            case 'When*'
                set command_to_run (string trim (string replace "When we run \"" "" (string replace "\"" "" $line)))
            case 'Then*'
                set expected_output (string trim (string replace "Then the output should include \"" "" (string replace "\"" "" $line)))
            case '*'
                # Ignore empty lines or comments.
        end
    end

    # Ensure the last scenario is run if the file doesn't end with an empty line.
    if set --query command_to_run
        run_scenario "$scenario_description" "$command_to_run" "$expected_output"
    end
end

# Example call to run BDD tests, replace 'path/to/your/bdd_tests.txt' with your actual test file path
run_bdd_tests 'path/to/your/bdd_tests.txt'
