# bind9-validation-action

This GitHub Action is designed to automate the validation of DNS zone files and BIND configuration files (`named.conf`) using `named-checkzone` and `named-checkconf`. 
It builds upon the features of the original [action-named-checkzone](https://github.com/grramos/action-named-checkzone) with enhancements aimed at speed improvements and addtional checks.

## Features
- **Zone File Validation**: Validates DNS zone files for syntax correctness using `named-checkzone`.
- **Configuration Validation**: Verifies the syntax of BIND configuration files (`named.conf`) using `named-checkconf`.
- **Automation**: Automatically runs on `push` and `pull_request` events, ensuring all changes are validated.

## Enhancements Over Original Action
- **Alpine Docker Image**: Utilizes a smaller Alpine-based Docker image, reducing the overall runtime footprint.
- **Dynamic Zone Name Extraction**: Instead of relying on zone filenames, this action extracts zone names directly from the `$ORIGIN` directive in zone files, ensuring greater accuracy and flexibility.
- **Enhanced `named.conf` Validation**: Specifically targets and verifies configuration files formatted like `named?.conf`, ensuring only relevant BIND configuration files are checked.

## Credits
This project is based on and extends [action-named-checkzone](https://github.com/grramos/action-named-checkzone) by [@grramos](https://github.com/grramos).
I want to express my gratitude for the groundwork laid in the original project, which inspired my enhancements.

## Usage
To use this action in your GitHub workflows, add the following to your workflow file (e.g., `.github/workflows/check-bind.yml`):

```yaml
name: Bind9 Validation

on: [push, pull_request]

jobs:
  bind9-validation:
    runs-on: ubuntu-latest

    steps:
    - name: Check out code
      uses: actions/checkout@main
    - name: Run named-checkzone
      uses: networkshokunin/bind9-validation-action@main
