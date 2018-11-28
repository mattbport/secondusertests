// All tests
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
~laneA.weight_(inf).sample_(\guitar);
~laneB.weight_(3).sample_(\bass);
~laneC.weight_(2).sample_(\drums);
~laneD.weight_(1).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;

// CASE 2
~myChooser.noseCone_(inf);
~laneA.weight_(1).sample_(\guitar);
~laneB.weight_(3).sample_(\bass);
~laneC.weight_(inf).sample_(\drums);
~laneD.weight_(2).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;


// CASE 2a
~myChooser.noseCone_(inf);
~laneA.weight_(0).sample_(\guitar);
~laneB.weight_(3).sample_(\bass);
~laneC.weight_(inf).sample_(\drums);
~laneD.weight_(2).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;

// CASE 2b
~myChooser.noseCone_(4);
~laneA.weight_(0).sample_(\guitar);
~laneB.weight_(3).sample_(\bass);
~laneC.weight_(inf).sample_(\drums);
~laneD.weight_(2).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;

// CASE 2c
~myChooser.noseCone_(2);
~laneA.weight_(0).sample_(\guitar);
~laneB.weight_(3).sample_(\bass);
~laneC.weight_(inf).sample_(\drums);
~laneD.weight_(2).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;

// CASE 3
~myChooser.noseCone_(3);
~laneA.weight_(inf).sample_(\guitar);
~laneB.weight_(inf).sample_(\bass);
~laneC.weight_(inf).sample_(\drums);
~laneD.weight_(inf).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;


// CASE 4
~myChooser.noseCone_(2);
~laneA.weight_(inf).sample_(\guitar);
~laneB.weight_(3).sample_(\bass);
~laneC.weight_(2).sample_(\drums);
~laneD.weight_(inf).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;


// CASE  5
~myChooser.noseCone_(3);
~laneA.weight_(2).sample_(\guitar);
~laneB.weight_(3).sample_(\bass);
~laneC.weight_(2).sample_(\drums);
~laneD.weight_(1).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;


// CASE 6
~myChooser.noseCone_(3);
~laneA.weight_(inf).sample_(\guitar);
~laneB.weight_(3).sample_(\bass);
~laneC.weight_(2).sample_(\drums);
~laneD.weight_(1).sample_(\vox);
~myChooser.nonDeterministicLaneChoice;


// CASE 7
~myChooser.noseCone_(3);
~laneA.weight_(0).sample_(\guitar);
~laneB.weight_(0).sample_(\bass);
~laneC.weight_(0).sample_(\drums);
~laneD.weight_(0).sample_(\vox);
~myChooser.chooseLanes;



// SAMPLES
// assumes /audio is in extension folder - probably the wrong place & needs changing

//Just do this bit once
SampleBank.populate;
// wait for it.....
SampleBank.warmUp;

// Do as  needed
~mySample = SampleBank.sampleDef(\guitar);
~mySample.createAndPlay;
~mySample.replay;
~mySample.play;
~mySample.inspect
~mySample.synth


// other stuff
~mySample.duration;
~mySample.pause;
~mySample.resume

~mySample.synth.run(false);
~mySample.synth.run(true);



// Abstract classes
AbstractChooser.new

// SCHEDULING A SAMPLE
~myClock = TempoClock.new(122/60);
~aPauseInBeats = 2;
~myClock.sched( ~aPauseInBeats, { ~mySample.play; nil});

