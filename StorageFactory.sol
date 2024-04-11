// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import { SimpleStorage } from "./SimpleStorage.sol";

contract StorageFactory{
   address []public ListOfSimpleStorage;

   function createSimpleStorage()public {
     ListOfSimpleStorage.push(address(new SimpleStorage()));
   }

   function sfStore(uint32 _index, uint32 _num)public {
      SimpleStorage simpleStorage = SimpleStorage(ListOfSimpleStorage[_index]);
      simpleStorage.store(_num);
   }

   function sfGet(uint32 _index)public view returns (uint256){
      SimpleStorage simpleStorage = SimpleStorage(ListOfSimpleStorage[_index]);
      return simpleStorage.retrieve();
   }
}