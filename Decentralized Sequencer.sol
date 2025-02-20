// Minor update: Comment added for GitHub contributions
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DecentralizedSequencer {
    address public admin;
    address[] public validators;
    mapping(address => bool) public isValidator;

    event TransactionSequenced(address indexed sender, bytes data);

    constructor(address[] memory _validators) {
        admin = msg.sender;
        for (uint i = 0; i < _validators.length; i++) {
            validators.push(_validators[i]);
            isValidator[_validators[i]] = true;
        }
    }

    function addValidator(address validator) external {
        require(msg.sender == admin, "Only admin can add validators");
        validators.push(validator);
        isValidator[validator] = true;
    }

    function sequenceTransaction(bytes calldata data) external {
        require(isValidator[msg.sender], "Only validators can sequence transactions");
        emit TransactionSequenced(msg.sender, data);
    }
}
