//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;

contract Ownable{
    address owner;
    
}

contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager __parentContract, uint _priceInWei, uint _index)public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = __parentContract;
    }

    receive() external payable{
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value,"only full payments allowed");
        pricePaid += msg.value;
        (bool success,) = address(parentContract).call{value:(msg.value)}(abi.encodeWithSignature( "triggerPayment(uint256)",index));
        require(success,"this transcation wasn't successfull, calceling");
    }

    fallback() external {}
}



contract ItemManager{

    enum SupplychainState{Created, Paid, Delivered}

    struct S_Item{
        Item _item;
        string _identifier;
        uint   _itemPrice;
        ItemManager.SupplychainState _state;
    }

    mapping(uint =>S_Item) items;
    uint itemIndex;

    event SupplyChainStep(uint _itemIndex,uint _step,address _itemAddress);

    function createItem(string memory _identifier,uint _itemPrice)public{
        Item item = new Item(this,_itemPrice,itemIndex);
        items[itemIndex]._item = item;
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice  = _itemPrice;
        items[itemIndex]._state      = SupplychainState.Created;
        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state),address(item));
        itemIndex ++;

    }

    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex]._itemPrice == msg.value,"Only full payment are accepted");
        require(items[_itemIndex]._state == SupplychainState.Created,"items are not created to payment");
        items[_itemIndex]._state = SupplychainState.Paid;

        emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state),address(items[_itemIndex]._item));
        

    }

    function triggerDelivery(uint _itemIndex) public {
        require(items[_itemIndex]._state == SupplychainState.Paid,"item in the further in the chain");
        items[_itemIndex]._state = SupplychainState.Delivered;

        emit SupplyChainStep(_itemIndex, uint(items[_itemIndex]._state),address(items[_itemIndex]._item));

    }

}