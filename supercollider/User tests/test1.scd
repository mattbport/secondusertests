TIME CHOOSER EXAMPLE
// JUST DO ONCE - CREATE SAMPLE BANK
     SampleBank.populate;
// Wait for it.....
      SampleBank.warmUp;   // add traces to show what sc classes involved

//////////////////////

// S1
// Sequence with marimba.wav, then bass.wav
// User then creates amen > bass > amen > stop

(
~ch1 = Xhooser.new;
~ch1.noseCone_(1);
~ch1.addLane( Lane.new.weight_(1).namedSample(\marimba));
 )
(
~ch2 = Xhooser.new;
~ch2.noseCone_(1);
~ch2.addLane( Lane.new.weight_(1).namedSample(\bass));
 )
(
~seq = Sequence.new;
~seq.add (~ch1);
~seq.add (~ch2);
)
(
~seq = Sequence.new;
~seq.add (~ch1);
~seq.add (~ch2);
~seq.add (~ch1);
)
~seq.play;

////////////////////////

// S2
(
~ch1 = Xhooser.new;
~ch1.noseCone_(1);
~ch1.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
 )

~ch1.play;



// S2 implementation question
(
~ch1 = Xhooser.new;
~ch1.noseCone_(2);
~ch1.addLane( Lane.new.weight_(2).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
 )

~ch1.play;

//////////////////////

// S3 userstanding question
(
~ch1 = Xhooser.new;
~ch1.noseCone_(2);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(2).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
)

~ch1.play;


// S3 implementation question
(
~ch1 = Xhooser.new;
~ch1.noseCone_(3);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(2).namedSample(\marimba).loopOn);
)

~ch1.play;

///////////////////////

// S4 understanding
(
~ch1 = Xhooser.new;
~ch1.noseCone_(2);
~ch1.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(2).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\vox).loopOn.softStopOn);
~tc1 = TimeChooser.new;
~tc1.noseCone_(1);
~tc1.addLane( TimeLane.new.beats_(4*4));
~ch1.timeChooser_(~tc1);
)

~ch1.play;


// S4 implementation
// Issue - same as above - due to two infinitely weighted lanes?
(
~ch2 = Xhooser.new;
~ch2.noseCone_(4);
~ch2.addLane( Lane.new.weight_(2).namedSample(\drums).loopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch2.addLane( Lane.new.weight_(inf).namedSample(\marimba).loopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\bvs).loopOn.softStopOn);
~ch2.addLane( Lane.new.weight_(inf).namedSample(\vox).loopOn.softStopOn);
~tc2 = TimeChooser.new;
~tc2.noseCone_(1);
~tc2.addLane( TimeLane.new.beats_(4*6));
~ch2.timeChooser_(~tc2);
)

~ch1.play;
~ch2.play;


(
~s4 = LoopableSequence.new;
~s4.add (~ch1);
~s4.add (~ch2);
)
~s4.play;

///////////////////


// S5 understanding
(
~ch1 = Xhooser.new;
~ch1.noseCone_(inf);
~ch1.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\vox).loopOn.softStopOn);
~tc1 = TimeChooser.new;
~tc1.noseCone_(1);
~tc1.addLane( TimeLane.new.weight_(2).beats_(4*4));
~tc1.addLane( TimeLane.new.weight_(1).beats_(4*6));
~tc1.addLane(TimeLane.new.weight_(1).namedSample(\marimba).playable_(false));
~ch1.timeChooser_(~tc1);
)

~ch1.play;





// S5 implementation
// First Chooser, no changes needed, all fine
(
~ch1 = Xhooser.new;
~ch1.noseCone_(2);
~ch1.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\vox).loopOn.softStopOn);
~tc1 = TimeChooser.new;
~tc1.noseCone_(1);
~tc1.addLane( TimeLane.new.weight_(1).beats_(4*4));
~tc1.addLane( TimeLane.new.weight_(1).beats_(4*6));
~ch1.timeChooser_(~tc1);
)

~ch1.play;

// Second Chooser - to play FIRST in the sequence
(
~ch2 = Xhooser.new;
~ch2.noseCone_(3);
~ch2.addLane( Lane.new.weight_(inf).namedSample(\drums).loopOn);
~ch2.addLane( Lane.new.weight_(inf).namedSample(\bass).loopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\bvs).loopOn.softStopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\vox).loopOn.softStopOn);
~tc2 = TimeChooser.new;
~tc2.noseCone_(1);
~tc2.addLane( TimeLane.new.weight_(3).beats_(4*4));
~tc2.addLane( TimeLane.new.weight_(1).beats_(4*8));
~ch2.timeChooser_(~tc2);
)

(
~s5 = LoopableSequence.new;
~s5.add (~ch2);
~s5.add (~ch1);
)

~s5.play;

////////////////////////////////

