// JUST DO ONCE - CREATE SAMPLE BANK
     SampleBank.populate;
// Wait for it.....
      SampleBank.warmUp;   // add traces to show what sc classes involved

SampleBank.at(\bass).play;
SampleBank.at(\guitar).play;

// DO ONCE FOR ALL CASES
~myChooser = Xhooser.new;

~laneA = Lane.new;
~laneB = Lane.new;
~laneC = Lane.new;
~laneD = Lane.new;

~myChooser.addLane(~laneA);
~myChooser.addLane(~laneB);
~myChooser.addLane(~laneC);
~myChooser.addLane(~laneD);

// CASE 1 - for all six cases ,try doing repeated evaluations
~myChooser.noseCone_(0);
~laneA.weight_(inf).namedSample(\guitar);
~laneB.weight_(3).namedSample(\bass);
~laneC.weight_(2).namedSample(\drums);
~laneD.weight_(1).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size; //when no lane can be chosen,  internal
                                              //size = 1 due to dummy lane - that's OK

// CASE 2
~myChooser.noseCone_(inf);
~laneA.weight_(1).namedSample(\guitar);
~laneB.weight_(3).namedSample(\bass);
~laneC.weight_(inf).namedSample(\drums);
~laneD.weight_(2).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;


// CASE 2a
~myChooser.noseCone_(inf);
~laneA.weight_(0).namedSample(\guitar);
~laneB.weight_(3).namedSample(\bass);
~laneC.weight_(inf).namedSample(\drums);
~laneD.weight_(2).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;


// CASE 2b *****
~myChooser.noseCone_(4);
~laneA.weight_(0).namedSample(\guitar);
~laneB.weight_(3).namedSample(\bass);
~laneC.weight_(inf).namedSample(\drums);
~laneD.weight_(2).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;


// CASE 2c
~myChooser.noseCone_(2);
~laneA.weight_(0).namedSample(\guitar);
~laneB.weight_(3).namedSample(\bass);
~laneC.weight_(inf).namedSample(\drums);
~laneD.weight_(2).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;


// CASE 3
~myChooser.noseCone_(3);
~laneA.weight_(inf).namedSample(\guitar);
~laneB.weight_(inf).namedSample(\bass);
~laneC.weight_(inf).namedSample(\drums);
~laneD.weight_(inf).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;




// CASE 4
~myChooser.noseCone_(2);
~laneA.weight_(inf).namedSample(\guitar);
~laneB.weight_(3).namedSample(\bass);
~laneC.weight_(2).namedSample(\drums);
~laneD.weight_(inf).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;


// CASE  5
~myChooser.noseCone_(3);
~laneA.weight_(2).namedSample(\guitar);
~laneB.weight_(3).namedSample(\bass);
~laneC.weight_(2).namedSample(\drums);
~laneD.weight_(1).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;


// CASE 6
~myChooser.noseCone_(3);
~laneA.weight_(inf).namedSample(\guitar);
~laneB.weight_(3).namedSample(\bass);
~laneC.weight_(2).namedSample(\drums);
~laneD.weight_(1).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;


// CASE 7
~myChooser.noseCone_(3);
~laneA.weight_(0).namedSample(\guitar);
~laneB.weight_(0).namedSample(\bass);
~laneC.weight_(0).namedSample(\drums);
~laneD.weight_(0).namedSample(\vox);
~myChooser.chooseLanes;
~myChooser.playChosenLanes;
~myChooser.chooseLanes.size;


~myChooser.chosenLanes;
~myChooser.chosenLanes.first;
~myChooser.chosenLanes.first.inspect



