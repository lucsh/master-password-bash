# Why?

Using the same password for multiple accounts is very
**unsafe**. If one of those sites gets compromisedit will affect all your accounts, possibly even leading to identity
theft.
The idea behind this proyect it that you memorise just one, reasonably long, secure
**master password** and use it to generate non-dictionary complex passwords.
This password generator works using JavaScript and the SHA-256 implementation extracted from digitalbazaar/forge, entirely within the page and **no data is ever passed back to the server**.
---
Uses the same logic as [https://pass.luc.sh](https://pass.luc.sh)

## Usage
eg:
`./spg.sh -s admin@service-enviroment`
