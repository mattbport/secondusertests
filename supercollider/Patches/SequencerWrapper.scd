SequencerWrapper // Decorator (I think)
// NOT WRITTEN YET
{
		var <>buffer ;       //  instacne vars in sample we might need to mimic
		var <>synth;
		var <> name;
	    var <> wavName;
	    var <>atomicRepeats;
	    var  <>loop;
	    var <> smartDuration = 0;

//====== QUERYING ===========
hasLoop {	   "DummySample".postln;     ^false}

hasNoLoop {   "DummySample".postln;   ^true}

loopStatus{  "DummySample".postln;   ^ 0}            //  Translates to 0 1 for Synth convenience

//========= SETTING VALUES  =======
loopOn {   "DummySample".postln;  ^ nil	}            //  (A) create a sequence / how about infinit sequence? BASICALLY DONE

loopOff {   "DummySample".postln;   ^ nil}

//========= INITIALIZING   =======
warmUp { "DummySample".postln;   ^nil}

createBuffer{  "DummySample".postln;    ^nil}

createSynthDef {  "DummySample".postln;   ^nil}

//========= CORE PROTOCOL  =======
play {  "DummySample".postln;   }                       //  (C) already implemented in Xhooser

hardPlay{  "DummySample".postln;   }                      //  (B)  impose a free on all lower synths . Should Xhooser reflect these ?
	                                                                           // allChosenSynths.free DONE

softPlay{  "DummySample".postln;  }

softDuration {  "DummySample".postln;   ^ 0 }     // (D) misleading name - its a setter - mixture of (A) and (B)

hardDuration {  "DummySample".postln;   ^0 }      //(E) misleading name - its a setter - issues FREE based on time chooser durations

pause {   "DummySample".postln;   }

resume {  "DummySample".postln;   }

basicDuration{  "DummySample basic duration".postln;  ^0}   (G)  //the version of duration already called by sequecne

duration{    "DummySample duration".postln;  ^ 0 }   //  already implemented - CALLED BY SEQUENCE
	                                                                             //   (F) but in wrapper needs to be the (D) or (E) time

//=========  Helper methods  =======
neededRepeatsFor{                                                    // we will need this kind of thing for (D)
		 arg softStopDuration;
		  "DummySample".postln;
		 ^nil
	}
}

// This protocol offers insight for making choosers nestable
// Does not need  protocol
// where  chooser calls  lane with news of presence or absence of time chooser
// and lane queries sample about  its basicduration
// and then lane calculates hard or soft duration based on its settings
// and tells sample  its smart duration, *which either lane or sample
// must tell tells seqeucne for proper sequencing



