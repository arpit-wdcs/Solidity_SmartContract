//SPDX-License-Identifier:MIT
pragma solidity >=0.4.24;

contract EnumsContract {

    // Create an Enumeration
   enum WDCS {chennai,ahamadabad,dubai,rajkot,USA}

   function getLocation(uint args)public pure returns(string memory location) {
       if(args == uint(WDCS.chennai)) return "chennai";
       if(args == uint(WDCS.ahamadabad))return "ahamadabad";
       if(args == uint(WDCS.dubai)) return "dubai";
       if(args == uint(WDCS.rajkot)) return "rajkot";
       if(args == uint(WDCS.USA)) return "USA";
       else { 
           revert("On given index is not present in enum");
        }
   }
}