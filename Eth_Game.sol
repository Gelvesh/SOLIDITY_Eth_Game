// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract EthGame{
    //The target amount of ether to be reached
    //3 ether is prefixed it can be changed
    uint256 public targetAmt = 3 ether;
    //Address of the winner who deposits the last ether required to achieve the target  
    address public winner;            
    //The current ether present 
    uint256 private balance;          

    //Function to deposit the ether
    function depositBet() public payable { 
        //The amount of ether to be deposited should be only 1 ether
        require(msg.value==1 ether,"You should deposit 1 Eth only");
        //Checks if the current balance is less than target amount else the Eth_Game is over 
        require(balance<targetAmt,"Game Over!");
        //Adds the 1 ether deposited to the balance
        balance+=msg.value;
        //Checks if the updated balance has achieved the target
        if(balance>=targetAmt){
            //If so , the one who deposits this ether is the winner
            winner=msg.sender;
        }
    }

    //Function to claim the reward only by the winner
    function claimReward() public{
        require(msg.sender==winner,"The Winner accesses this...");
        //Transfers the ether present to the address who calls this function .i.e. Winner
        (bool sent,)=msg.sender.call{value:address(this).balance}("");
        //Requires 'Sent' to be true for Successfull transaction
        require(sent,"Transaction Failed...");
    }

    //View the ether present in the Balance
    function viewBalance() public view returns(uint256){
        return address(this).balance;
    }
}