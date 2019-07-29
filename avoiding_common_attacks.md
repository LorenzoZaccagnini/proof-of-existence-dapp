# Avoiding Common Attacks

* **Keep it simple:** The smart contract structure is very simple, complex structures tends to be harder to keep secure from attacks. Less code, more security.

* **Restrict Access:** A map of the ownership of the files `mapping (uint => address) public dataOwner` is used to restrict access only to the owner of the uploaded files

* **Check strings:** The contract uses a modifier to validate all the string inputs to restrict to the allowed maximum length size

* **Unit testing:** Unit testing is used to check the smart contract security

* **Fail fast and early:** Using modifiers and requires (in the first lines of code) allows the contract to interrupt immediately an action before executing the rest of the code.

* **Circuit Breaker:** The contract owner can lock/unlock the contract in case of emergency
