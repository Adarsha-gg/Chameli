// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {Script} from "forge-std/Script.sol";
import {Chameli} from "../src/ChameliToken.sol";

contract DeployChameli is Script {
    uint256 public constant InitialSupply = 1000 ether;
    function run() external returns(Chameli){
        vm.startBroadcast();
        Chameli chameli = new Chameli(InitialSupply);
        vm.stopBroadcast();
        return chameli;
    }
}
