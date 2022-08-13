//  SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.9.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    using SafeMathChainlink for uint;

    mapping(address=>uint) public senderaddresstoamontvalue;

    function fund() public payable {
        senderaddresstoamontvalue[msg.sender] += msg.value;
    }

    function getVersion() public view returns(uint){
        return AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e).version();
    }

    function getPrice() public view returns(uint){
        (,int256 answer,,,) = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e).latestRoundData();
        uint8 decimal = uint8(getDecimals());
        uint8 multiplier = uint8(10 ** (18 - decimal));
        return uint(answer * multiplier);
    }

    function getDecimals() public view returns(uint8){
      return AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e).decimals();
    }
    
    function getEtherPrice(uint weiPrice) public pure returns(uint){
      return (weiPrice / (10 ** 18));
    }
    
    function getConversionRate(uint ethAmount) public view returns(uint){
      return (ethAmount * getEtherPrice(getPrice()));
    }
}
