TIME CHOOSER EXAMPLE
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


// PLAY CHOOSER
~ch1.play;
~ch1.playChosenLanes;  // To study a single choice,  do play once first then use  playChosen, not play - freezes the choices.
~ch1.pause;
~ch1.resume;
~ch1.inspect;
~ch1.explore
~ch1.duration


// SCHEDULE  A Sequence of CHOOSERS
~seq = Sequence.new;
~seq.add (~ch1);
~seq.add (~ch2);
~seq.add (~ch3);
~seq.play;
~seq.playChosen // To study a single choice,  do play once first then use  playChosen, not play - freezes the choices.
~seq.inspect;
~seq.explore
~seq.choosers.size



