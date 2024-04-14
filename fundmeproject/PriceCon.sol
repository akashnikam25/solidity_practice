// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceCon{

    function getPrice()internal view returns (uint256){
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
        return uint256(answer * 1e10);
    }
    function getPriceConversion(uint256 ethVal)internal view returns(uint256){
        uint256 val = getPrice() * ethVal / 1e18;
        return val;
    }
}