// SPDX-License-Identifier : MIT

pragma solidity ^0.8.18;

contract Chameli{

    mapping(address => uint256) private s_balances;

    function name() public pure returns(string memory)
    {
        return "Chameli";
    }

    function totalsupply() public pure returns (uint256){
        return 3333 ether;
    }

    function decimals() public pure returns(uint8){
        return 18;
    }

    function balanceof(address _user) public view returns (uint256){
        return s_balances[_user];
    }

    function transfer(address _to, uint256 _amount) public{
        uint256 previous_balance = balanceof(msg.sender) + balanceof(_to);
        s_balances[msg.sender] -= _amount; 
        s_balances[_to] += _amount;
        require(balanceof(msg.sender) + balanceof(_to) == previous_balance);
    }
}