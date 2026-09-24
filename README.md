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
