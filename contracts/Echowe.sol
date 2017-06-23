pragma solidity ^0.4.4;

contract Echowe {

   struct oneSong {
    string songname;
    address[] holder;
    uint[] percent;
  }
  struct oneMix {
    string[] songnames;
    address[] holders;
    uint[] percents;
  }

  struct sampleOne {
    string mashname;
    oneSong[] songs;
    uint mypercent;
    uint numsongs;
    address[] newholder;
    uint[] samplepercent;
  }

  struct sampleMix {
     string mashname;
     oneSong[] songs;
     oneMix[] mixes;
     uint numsongnmix;
     uint mypercent;
     address[] mashholder;
     uint[] samplepercent;
   }

  uint revenue;
  sampleOne mySampleOne;
  sampleMix mySampleMix;

  function Echowe() {
    // constructor
  }

  function createSampleFromOneSong(string name, oneSong[] hgf, address[] cpholders, uint[] percents){
    sampleOne mySong;
    mySong.mashname = name;
    mySong.songs = hgf;
    mySong.numsongs = mySong.songs.length;
    mySong.newholder = cpholders;
    mySong.samplepercent = percents;
  }

  function createSampleFromMix(string name, oneSong[] copyrightedsongs, oneMix[] mixedsongs, address[] cpholders, uint[] percents){
    sampleMix myMix;
    myMix.mashname = name;
    myMix.songs = copyrightedsongs;
    myMix.mixes = mixedsongs;
    myMix.numsongnmix = myMix.songs.length + myMix.mixes.length;
    myMix.mashholder = cpholders;
    myMix.samplepercent = percents;
  }

  function distributeRevenueOneSong(uint revenue,sampleOne mySampleOne){
    uint left = revenue;
    for (int i=0; i < mySampleOne.numsongs; i ++) {
      for (int j = 0; j < mySampleOne.songs[i].percent.length; j ++) {
        mySampleOne.holder[j].send(mySampleOne.songs[i].percent[j] / 100 * (mySampleOne.numsongs /100) * revenue);
        left -= mySampleOne.songs[i].percent[j] / 100 * (mySampleOne.numsongs /100) * revenue;
      }
    }
    for (i=0; i < mySampleOne.newholders.length; i++) {
      mySampleOne.newholder[i].send(1/mySampleOne.newholder.length * left);
    }
  }

  function distributeRevenueMix(uint revenue, sampleMix mySampleMix){
    uint left = revenue;
    for (int i = 0; i < mySampleMix.songs.length; i ++) {
      for (int j = 0; j < mySampleMix.songs[i].percent.length; j ++) {
        mySampleMix.holder[j].send(mySampleMix.songs[i].percent[j] / 100 * (mySampleMix.numsongnmix /100) * revenue);
        left -= mySampleMix.songs[i].percent[j] / 100 * (mySampleMix.numsongs /100) * revenue;
      }
    }
    for (i = 0; i < mySampleMix.mixes.length; i ++) {
      for (j = 0; j < mySampleMix.songs[i].percent.length; j ++) {
        mySampleMix.holder[j].send(mySampleMix.songs[i].percent[j] / 100 * (mySampleMix.numsongnmix /100) * revenue);
        left -= mySampleMix.songs[i].percent[j] / 100 * (mySampleMix.numsongnmix /100) * revenue;
      }
    }
    for (i=0; i < mySampleMix.newholders.length; i++) {
      mySampleMix.newholder[i].send(1/mySampleMix.newholder.length * left);
    }
  }


  /// Create a new contract with $(_numsongs) different copyrighted songs.
   ///function newcontract(onesong[] copyrightedsongs, string name) {

   ///}
}
