# Calc

A simple calculator writen in V!

This calculator allows the user to compute simple expressions such as:
```text
(1 + 2) * 3
```
Parsing the expression and returning the correct value as f64 number.

---

## How to use

### Install Vlang

Follow the instructions to install V on your device

[V's official repo](https://github.com/vlang/v)

### Clone this repo

```bash
git clone https://TasteLessTree/calc.git
cd calc
```
### Compile

Compile and generate the ```calc``` executable
```bash
v .
```

Or compile and run
```bash
v run .
```

#### RELP

Write an expression on calc's RELP
```text
(1 + 2) * 3
```

Or use ```exit``` to quit the RELP
```text
exit
```

#### Command Line Arguments

Calc also accepts command line arguments
```bash
./calc 3 + 2
```

Or
```bash
v run . 3 + 2
```

##### Errors
-----

When using command line arguments and parenthesis, to avoid the following errors on your current shell:
```bash
v run . (1 + 2) * 3
bash: syntax error near unexpected token `('
```

```zsh
v run . (5 - 3) * 4
zsh: unknown file attribute: 5
```

Please, surround the full expression with double quotes (```"```)

```bash
v run . "(1 + 2) * 3"
Result: 9.0
```

```zsh
v run . "(5 - 3) * 4"
Result: 8.0
```

Try using double quotes (```"```) if you encounter any errors with command line arguments

---

## Tests

Test files can be found under the ```tests``` directory

Execute the tests with the command
```bash
v test .
```

---

## License

Distributed under the [MIT LICENSE](LICENSE.txt)

## Author

[TasteLessTree](https://github.com/TasteLessTree)
