//Lanes in time choosers CAN contain samples- but mainly they contain durations U
//UPDATED


Lane {
	var <>weight;
	var <>loop;
	var <>loopTimes;   // usually inf
	var <>stop;
	var <>sample;                // Sample might have protocol -
	                                       //play, duration, name, repeatTimes, synth
	                                       // NESTING pretty sure could allow SAMPLE to be
	                                       // chooser and so have nesting
                                           //  Lane could refer  directly to Xhooser or Time chooser  -
	                                       // but probably best not due to memory leaks etc
	                                       //  Problem is Lane needs to know TC duration
	                                        // to caclulate Smart duration nlocally
	                                       //  best to pass referecne as atgumeny

*new { ^ super.new.init}

*null { ^super.new}
	                                       // might help when validly no lane can be chosen
	                                        // vs inconvenient  empty list
	                                       // see also dummy Sample class - similar idea

init{
	weight = 1;
	loop = false;
    stop = \hard ;
	loopTimes = inf
	}




printOn { | aStream |

		this.isNull.if { aStream << "a " << "null"  << this.class.name; ^aStream};
		aStream << " ** " /*<< this.class.name */<< " w " << this.weight.asString ;
		aStream << " "<<  this.stop.asString << " " ;
		this.hasLoop.if( {   aStream <<  " loops "  });
		this.sample.isSymbol.if( {   aStream <<  " " << this.sample.asString; ^aStream });
		this.sample.isNil.not.if( {   aStream <<  " " << this.sample.name.asString << " ";
			                                     aStream << this.sample.basicDuration << " ";
			                                     aStream <<  " smart " << this.smartDuration << " "

		});
		^aStream}


//===== INIT in Dummy Sample case ===================

dummyInit{
sample = DummySample.new }


goDummy{ this.sample_(DummySample.new); ^ DummySample.new}

//=============   TESTING  ====================


isNull{
		^ (this.weight ==nil) }

hasInfiniteWeight {
		^ (this.weight ==inf) }

hasZeroWeight{
		^ (this.weight ==0) }

hasHardStop {
		^this.stop == \hard}

hasSoftStop {
		^this.stop == \soft}

hasLoop {
		^this.loop == true}

hasNoLoop {
		^this.loop == false}


hasNoStop {}    // do we need  this?


hasActiveTimeChooser{
		arg aParentChooser ;
		var good;
		aParentChooser.isNil.if { ^ false};
				good = aParentChooser.hasActiveTimeChooser;
		        "time chooser hasActiveTimeChooser". postln;
		^ good
	}


//=============   SETTERS  ====================

hardStopOn	{
		this.stop_ (\hard)}

softStopOn{
		this.stop_ (\soft)}

neitherStopOn{}  //do we need  this?

loopOn {
		this.loop_ (true)}

loopOff {
		this.loop_ (false)}

namedSample{
		arg aSymbol;
		this.sample_(SampleBank.sampleDef(aSymbol));
	}

//============ ACTIONS ================

	play{
		this.hasLoop.if {this.sample.loopOn};
		  this.sample.play
		//this.isNull.if {^nil};
		//this.sample.isNil.if({ ^nil}, {this.sample.play})
		// needs to deal with case if lane is empty
        	}

pause {
		this.sample.pause
	}

resume {
		this.sample.resume
	}


playWithChosenTimeLaneForParent{   //KEY METHOD - NB  TAKES A PARAMETER
		arg chosenTimeLane, aParent;      // can only be called by chooser
		var timeLaneDuration;

		timeLaneDuration = chosenTimeLane.duration;
		this.isNull.if {^nil};
		this.sample.isNil.if({ ^nil},
			{ this.hasHardStop.if {this.sample.hardPlay(timeLaneDuration)};
				this.hasSoftStop.if {this.sample.softPlay(timeLaneDuration)};
		})                                                   // needs to deal with case if lane is empty
        }


// ============ DURATION - some may be redundant or need refactoring ================


//================ DEFINITIVE DURATION FOR ALL EXTERNAL QUERIES =============

duration{
		this.isNull.if {^0};
		^this.smartDuration
        	}

//================  DURATION IF NO TIME LANE - used in internal calculations only ===================

localDuration{
		(this.sample.class == DummySample).if { ^0 };
		this.sample.isNil.if { this.goDummy };
		^ (this.sample.duration) *  (this.loopDurationMultiplier) }



// ========== SMART DURATIONS==================
// Smart Durations are not needed to hard & soft stop correctly correctly,
// but are needed to sequence choosers correctly so that total durationof soft stops is known in advance
// They are calculated here but stored in the sample


smartDuration{
		^this.sample.smartDuration}


// =======  Chooser decides which of these two methods  for calculating smart duration to call ==========
// This is not needed to hard & soft stop correctly correctly - just for sequencing

calculateSmartDurationWithNoActiveTimeLane{
		this.sample.isNil.if { this.goDummy};
		this.sample.smartDuration_(this.localDuration);
        ^this.localDuration }


calculateSmartDurationWithChosenTimeLaneForParent{  //KEY METHOD
		                                                                             //- NB  TAKES A PARAMETER
	arg chosenTimeLane, aParent;
		var timeLaneDuration;
		chosenTimeLane.isNil.if{ this.sample.smartDuration_(this.sample.basicDuration);
			                                 ^this.sample.basicDuration };

		timeLaneDuration = chosenTimeLane.duration;

		this.isNull.if {^nil};
		this.sample.isNil.if({ ^nil},
			{ this.hasHardStop.if {^ this.sample.hardDuration(timeLaneDuration)};  // misleading name - this is a setter
				this.hasSoftStop.if { ^ this.sample.softDuration(timeLaneDuration)};  // misleading name - this is a setter
		})
	}



// ========== duration helper in case of finite repetition loops==================
loopDurationMultiplier{
		this.hasNoLoop.if{^1};
		this.hasLoop.if{^this.loopTimes};
	}


durationGivenNRepeats{
		arg num ;
		^ num* (this.sample.duration);
			}



//============= Appear to be  UNUSED  ===============

noOfRepeatsRequiredForSoftStopWithTimeLaneOfDuration{
		arg num ;
		this.sample.isNil.if { "No sample found when calulating soft stop".postln; this.halt};
		(this.sample.duration == inf).if{^0};
		this.isNull.if{"Should not happen".postln};
		^ num/ (this.sample.duration)	}



durationForSoftStopGivenTimeLaneWithDuration{
		arg num ;
		var repeats;
				repeats = this. noOfRepeatsRequiredForSoftStopWithTimeLaneOfDuration (num);
			^	this.durationGivenNRepeats(repeats);
           	}



durationOfChosenTimeLane{
		arg aParentChooser ;
		 aParentChooser.isNil.if { "No parent chooser, so can't check chosen  timeLane duration".postln;  ^nil};
				^aParentChooser.durationOfChosenTimeLane;
	}


performanceDuration{
	arg aParentChooser ;
	var guideDuration;
	var activeTC ;
	   "in performance  duration".postln;
		activeTC = this.hasActiveTimeChooser(aParentChooser);
		activeTC.not.if  {"no active time chooser".postln;  ^ this.localDuration};
		guideDuration= this.durationOfChosenTimeLane;
		(this.hasHardStop.and({activeTC})).if {"hard stop".postln; ^ guideDuration};
		(this.hasSoftStop.and({activeTC})).if { "soft stop".postln;
				^ this.durationForSoftStopGivenTimeLaneWithDuration(guideDuration)};
			}





 }