// JUST DO ONCE - CREATE SAMPLE BANK
     SampleBank.populate;
// Wait for it.....
      SampleBank.warmUp;   // add traces to show what sc classes involved


// S5 understanding
// All fine apart from the lack of soundable content in the time chooser

~ch1 = Xhooser.new;
~ch1.name_("CHOOSER ONE - runs second");
~ch1.noseCone_(inf);
~ch1.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\marimba).loopOn.softStopOn);
~tc1 = TimeChooser.new;
~tc1.noseCone_(1);
~tc1.addLane( TimeLane.new.weight_(2).beats_(4*4));
~tc1.addLane( TimeLane.new.weight_(1).beats_(4*6));
~tc1.addLane(TimeLane.new.weight_(1).namedSample(\marimba).playable_(true));
~ch1.timeChooser_(~tc1);


~ch1.play;



// S5 implementation
// First Chooser, no changes needed, all fine

~ch2 = Xhooser.new;
~ch2.name_("CHOOSER TWO - runs first");
~ch2.noseCone_(2);
~ch2.addLane( Lane.new.weight_(1).namedSample(\drums).loopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\bass).loopOn);
~ch2.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch2.addLane( Lane.new.weight_(inf).namedSample(\vox).loopOn);
~tc2 = TimeChooser.new;
~tc2.noseCone_(1);
~tc2.addLane( TimeLane.new.weight_(inf).beats_(4*4));
~tc2.addLane( TimeLane.new.weight_(1).beats_(4*8));
~ch2.timeChooser_(~tc2);

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


~s5 = LoopableSequence.new;
~s5.add (~ch2);
~s5.add (~ch1);


~s5.play;

~ch2.playChosen;
~ch2.playChosen.duration
~ch2.duration;
~ch2.inspect;
~ch1.playChosen;
~s5.playChosen;
~s5.inspect;