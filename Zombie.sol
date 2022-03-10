pragma solidity >= 0.5.0 < 0.6.0;
import "./Zombieattack.sol";
import "./erc721.sol";

contract zombieOwnership is ERC721, Zombieattack{

    mapping (uint => address)zombieAppoval;



       function balanceOf(address _owner)external view returns(uint256){
           return ownerzombieCount[_owner];

      }

      function ownerOf(uint256 _tokenId)external view returns(address){
          return zombieToOwner[_tokenId];
      }

      function _transfer(address _from, address _to, uint256 _tokenId) private {
          ownerzombieCount[_to++;
          ownerzombieCount[_from]--;
          zombieToOwner[_tokenId] = _to;
          emit transfer(_from,_to,_tokenId);
      }

      function transferFrom(address _from, uint256 _tokenId)external payable{


      }

      function approve(address _from, uint256 _tokenId)external payable{
          
      }
}