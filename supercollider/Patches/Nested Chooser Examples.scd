// RECURSION EXAMPLES
// JUST DO ONCE - CREATE SAMPLE BANK
     SampleBank.populate;
// Wait for it.....
      SampleBank.warmUp;   // add traces to show what sc classes involved


//  CREATE A CHOOSER 1
~ch1 = Xhooser.new;
~ch1.noseCone_(2);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar));
~ch1.addLane( Lane.new.weight_(3).namedSample(\bass).loopOn.softStopOn);
~ch1.addLane( Lane.new.weight_(2).namedSample(\drums));
~ch1.addLane( Lane.new.weight_(1).namedSample(\vox));
~tc1 = TimeChooser.new;
~tc1.noseCone_(1);
~tc1.addLane( TimeLane.new.beats_(6));
~tc1.addLane( TimeLane.new.beats_(10));
~ch1.timeChooser_(~tc1);

//  CREATE A CHOOSER 2
~ch2 = Xhooser.new;
~ch2.noseCone_(2);
~ch2.addLane( Lane.new.weight_(1).namedSample(\guitar));
~ch2.addLane( Lane.new.weight_(3).namedSample(\bass).loopOn);
~ch2.addLane( Lane.new.weight_(inf).namedSample(\drums).loopOn.softStopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\vox));
~tc2 = TimeChooser.new;
~tc2.noseCone_(1);
~tc2.addLane( TimeLane.new.beats_(5));
~tc2.addLane( TimeLane.new.beats_(10));
~ch2.timeChooser_(~tc2);


//  CREATE A CHOOSER 3
~ch3 = Xhooser.new;
~ch3.noseCone_(3);
~ch3.addLane( Lane.new.weight_(1).namedSample(\guitar));
~ch3.addLane( Lane.new.weight_(inf).namedSample(\bass).loopOn.softStopOn);
~ch3.addLane( Lane.new.weight_(2).namedSample(\drums));
~ch3.addLane( Lane.new.weight_(1).namedSample(\vox));
~tc3 = TimeChooser.new;
~tc3.noseCone_(1);
~tc3.addLane( TimeLane.new.beats_(6));
~tc3.addLane( TimeLane.new.beats_(10));
~ch3.timeChooser_(~tc3);

// LoopableSequence
~seq = LoopableSequence.new;
~seq.loopTimes_(3);
~seq.add (~ch1);
~seq.add (~ch2);
~seq.add (~ch3);
~seq.play;
~seq.playChosen; // To study a single choice,  do play once first then use  playChosen,
                            // not play - freezes the choices.
~seq.duration;
~seq.kill;
~seq.allSequencedSynths;
~seq.clocks;
~seq.stop;
~seq.free;
~seq.clear;

~ch1.playChosenLanes;  // aha!!!
~seq.inspect;
~seq.explore;
~seq.choosers.size;


// Nested Chooser
// Needs testing
~ch3 = Xhooser.new;
~ch3.noseCone_(1);
~ch3.addLane( Lane.new.weight_(0).namedSample(\guitar));
~ch3.addLane( Lane.new.weight_(0).namedSample(\bass).loopOn.softStopOn);
~ch3.addLane( Lane.new.weight_(inf).loopOff.nest(~ch1));
~ch3.addLane( Lane.new.weight_(0).namedSample(\vox));
~tc3 = TimeChooser.new;
~tc3.noseCone_(1);
~tc3.addLane( TimeLane.new.beats_(6));
//~tc3.addLane( TimeLane.new.beats_(10));
~ch3.timeChooser_(~tc3);
~ch3.play

~ch3.playChosenLanes;
~ch1.play;

// CAN WE NEST TWICE??
// Needs testing & maybe debugging

// Nest Once
~ch3 = Xhooser.new;
~ch3.noseCone_(1);
~ch3.addLane( Lane.new.weight_(0).namedSample(\guitar));
~ch3.addLane( Lane.new.weight_(0).namedSample(\bass).loopOn.softStopOn);
~ch3.addLane( Lane.new.weight_(inf).loopOff.nest(~ch1));
~ch3.addLane( Lane.new.weight_(0).namedSample(\vox));
~tc3 = TimeChooser.new;
~tc3.noseCone_(1);
~tc3.addLane( TimeLane.new.beats_(6));
//~tc3.addLane( TimeLane.new.beats_(10));
~ch3.timeChooser_(~tc3);
~ch3.play

// Nest twice
~ch4 = Xhooser.new;
~ch4.noseCone_(3);
~ch3.addLane( Lane.new.weight_(inf).loopOff.nest(~ch3));
~ch4.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn.softStopOn);
~ch4.addLane( Lane.new.weight_(2).namedSample(\drums));
~ch4.addLane( Lane.new.weight_(0).namedSample(\vox));
~tc4 = TimeChooser.new;
~tc4.noseCone_(1);
~tc4.addLane( TimeLane.new.beats_(6));
~tc4.addLane( TimeLane.new.beats_( 10));
~tc4.addLane( TimeLane.new.weight_(200).namedSample(\vox).playable_(true));
~ch4.timeChooser_(~tc4);

~ch4.play






