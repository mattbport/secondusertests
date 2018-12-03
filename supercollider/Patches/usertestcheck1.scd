TIME CHOOSER EXAMPLE
// JUST DO ONCE - CREATE SAMPLE BANK
     SampleBank.populate;
// Wait for it.....
      SampleBank.warmUp;   // add traces to show what sc classes involved


// S1
// Sequence with amen.wav, then bass.wav
// User then creates amen > bass > amen > stop





// S2
// All good! Still getting the 'isSymbol' error, but fully functional
(
~ch1 = Xhooser.new;
~ch1.noseCone_(1);
~ch1.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
 )

~ch1.play;

~ch1.chosenLanes.inspect;
~ch1.inspect;


// S2 implementation question. All fine.
(
~ch1 = Xhooser.new;
~ch1.noseCone_(2);
~ch1.addLane( Lane.new.weight_(2).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
 )




// S3 userstanding question
// all fine
(
~ch1 = Xhooser.new;
~ch1.noseCone_(2);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(2).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
)

~ch1.play;


// S3 implementation question
// Fixed
(
~ch1 = Xhooser.new;
~ch1.noseCone_(3);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(2).namedSample(\marimba).loopOn);
)

~ch1.play;



// S4 understanding
// All fine
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
~ch1 = Xhooser.new;
~ch1.noseCone_(3);
~ch1.addLane( Lane.new.weight_(2).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\marimba).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bvs).loopOn.softStopOn);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\vox).loopOn.softStopOn);
~tc1 = TimeChooser.new;
~tc1.noseCone_(1);
~tc1.addLane( TimeLane.new.beats_(4*8));
~ch1.timeChooser_(~tc1);
)

~ch1.play;
~ch1.playChosenLanes; // same again
// FAILURE IN SERVER - doesn't seem to be an issue??



// S5 understanding
// All fine apart from the lack of soundable content in the time chooser
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
~tc1.addLane(TimeLane.new.weight_(1).namedSample(\marimba).playable_(true));
~ch1.timeChooser_(~tc1);
)

~ch1.play;


////////////////////////////////////////////

// Here is an example to show the current bug
// The following two Choosers should be identical
// The first has ∞ soundable nose cone with four lanes
// The second uses the number 4 in the nose cone -> same result
// However, the use of ∞ in the soundable nose cone seems to
// prevent the soundable in the time chooser from playing

(
~ch1 = Xhooser.new;
~ch1.noseCone_(inf); // No audible marimba
~ch1.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\vox).loopOn.softStopOn);
~tc1 = TimeChooser.new;
~tc1.noseCone_(1);
~tc1.addLane( TimeLane.new.weight_(2).beats_(4*4));
~tc1.addLane( TimeLane.new.weight_(1).beats_(4*6));
~tc1.addLane(TimeLane.new.weight_(inf).namedSample(\marimba).playable_(true));
~ch1.timeChooser_(~tc1);
)

~ch1.play;


(
~ch1 = Xhooser.new;
~ch1.noseCone_(4); // This makes the marimba audible
~ch1.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\vox).loopOn.softStopOn);
~tc1 = TimeChooser.new;
~tc1.noseCone_(1);
~tc1.addLane( TimeLane.new.weight_(2).beats_(4*4));
~tc1.addLane( TimeLane.new.weight_(1).beats_(4*6));
~tc1.addLane(TimeLane.new.weight_(inf).namedSample(\marimba).playable_(true));
~ch1.timeChooser_(~tc1);
)

/////////////////////////////////////////////////



// S5 implementation
// First Chooser, no changes needed, all fine
(
~ch2 = Xhooser.new;
~ch2.noseCone_(2);
~ch2.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch2.addLane( Lane.new.weight_(inf).namedSample(\vox).loopOn);
~tc2 = TimeChooser.new;
~tc2.noseCone_(1);
~tc2.addLane( TimeLane.new.weight_(2).beats_(4*4));
~tc2.addLane( TimeLane.new.weight_(1).beats_(4*8));
~ch2.timeChooser_(~tc2);
)

~ch2.play;

// Second Chooser
// ISSUE multiple infinite weights in the Soundable - error
// (
// ~ch2 = Xhooser.new;
// ~ch2.noseCone_(inf);
// ~ch2.addLane( Lane.new.weight_(inf).namedSample(\drums).loopOn);
// ~ch2.addLane( Lane.new.weight_(inf).namedSample(\bass).loopOn);
// ~ch2.addLane( Lane.new.weight_(1).namedSample(\bvs).loopOn.softStopOn);
// ~ch2.addLane( Lane.new.weight_(1).namedSample(\vox).loopOn.softStopOn);
// ~tc2 = TimeChooser.new;
// ~tc2.noseCone_(1);
// ~tc2.addLane( TimeLane.new.weight_(3).beats_(4*4));
// ~tc2.addLane( TimeLane.new.weight_(1).beats_(4*8));
// ~tc1.addLane( TimeLane.new.beats_(4*8)); // how to add a sample - marimba??
// ~ch2.timeChooser_(~tc2);
// )

(
~s5 = LoopableSequence.new;
~s5.add (~ch2);
~s5.add (~ch1);
)

~s5.play;


/*
/────┬──────────────────┬───┬───┬───┐
│    │    drums.wav     │ ∞ │x∞ │ h │
│    ├──────────────────┼───┼───┼───┤
│    │     bass.wav     │ 2 │x2 │ h │
│ ∞  ├──────────────────┼───┼───┼───┤
│    │    guitar.wav    │ 1 │x1 │ h │
│    ├──────────────────┼───┼───┼───┤
│    │     vox.wav      │ ∞ │x∞ │ s │
├────┼──────────────────┴───┴───┼───┤
│    │          4 bars          │ 2 │
│    ├──────────────────────────┼───┤
│ 1  │          6 bars          │ 1 │
│    ├──────────────────────────┼───┤
│    │          8 bars          │ 2 │
\────┴──────────────────────────┴───┘
*/


//////////////

// PLAY CHOOSER
~ch1.play;
~ch1.playChosenLanes;  // To study a single choice,  do play once first then use  playChosen, not play - freezes the choices.
~ch1.pause;
~ch1.resume;
~ch1.inspect;
~ch1.explore
~ch1.duration


// SCHEDULE  A Sequence of CHOOSERS
(
~seq = Sequence.new;
~seq.add (~ch1);
~seq.add (~ch2);
~seq.add (~ch3);
)
~seq.play;
~seq.playChosen // To study a single choice,  do play once first then use  playChosen, not play - freezes the choices.
~seq.inspect;
~seq.explore
~seq.choosers.size



