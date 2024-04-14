// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {PriceCon} from "./PriceCon.sol";

error NotOwner();

contract Fundme {

    uint256 public constant minimumUsd = 5e18;
    using PriceCon for uint256;
    address [] public  funders;
    mapping (address => uint256) public addressToAmtFunded;
    address public immutable owner;
    constructor(){
        owner = msg.sender;
    }
    function fund() public payable  {
        require(msg.value.getPriceConversion() >= minimumUsd, "Didn't send enough ether");
        funders.push(msg.sender);

        addressToAmtFunded[msg.sender] += msg.value;
    }

    function withdraw() public  onlyOwner {

            for (uint256 i = 0 ;i < funders.length;i++){
                address funder = funders[i];
                addressToAmtFunded[funder] = 0;
            }
            
            funders = new address[](0);

            (bool callSuccess, )= payable(msg.sender).call{value: address(this).balance}("");
            require(callSuccess, "call Failed");
        
    }

    modifier onlyOwner() {
     // require(owner == msg.sender, "must be owner") ;

     if (owner == msg.sender){
        revert NotOwner();
     }
      _;
    }

    receive() external payable { 
        fund();
    }
    fallback() external payable { 
        fund();
    }
  
   
}
