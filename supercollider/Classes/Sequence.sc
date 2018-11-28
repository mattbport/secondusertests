Sequence{   // or sequencer better name? NO

	var <>choosers;
	var<> timeline;

*new{
		var me;
		^ super.new.init;}

init{ choosers = List.new;
		timeline = List.new
	}

add{arg aChooser;
	this.choosers.add(aChooser)}

addAll{arg aList;
	this.choosers.addAll(aList)}

schedule{arg aPauseInBeats, /*aDurationInBeats, */ aChooser;
		TempoClock(SampleBank.tempo).sched ( aPauseInBeats, {  aChooser.playChosenLanes; nil  });
	     this.logEntry(aPauseInBeats, aChooser); // play prechosen, else choice not made till scheduled

	}

play{
		choosers.do{ |eachChooser| eachChooser.chooseLanes}; // needed for recursion to work
		this.playChosen }

playChosen{
		timeline = List.new;
		choosers.inject(0,{ arg thisPauseInBeats, eachChooser ;
		                              this.schedule(thisPauseInBeats, /*aDurationInBeats, */ eachChooser );
			                              thisPauseInBeats + eachChooser.duration} ) }




logEntry{	arg beats, aChooser;
		aChooser.isNil.if({"Chooser is nil - should not happen".postln; ^nil});
		                this.timeline.add(beats -> aChooser.chosenLanesAsArray);
	}


explore	{
		this.timeline.asArray.inspect}


printOn { | aStream |
		aStream << "a " << this.class.name << "  " <<  this.timeline;
		^aStream}

	stop{ // there's probably some way - apart from splat fullstop
	}

}