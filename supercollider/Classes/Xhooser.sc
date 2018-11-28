Xhooser {
	var <>noseCone;
	var <>lanes;
	var <>chosenLanes;
	var <> timeChooser;
	var <> journal ;
	   // but could record an event stream - instance of non det command pattern?

// =====  INITIALIZATION	 =======
init{
	lanes = List.new;
		chosenLanes = List.new;
		journal = List.new
	}

*new { ^ super.new.init}

// ====== LANE ADDING & REMOVAL  =========
addLane{
		arg aLane;
		this.lanes.add(aLane)}

//======= Printing  ==========
	printOn { | aStream |
		aStream << "a " << this.class.name << " chosen lanes " <<  this.chosenLanes;
		^aStream}

	journalAsArray {
		^ this.journal.asArray}

	chosenLanesAsArray {
		^ this.chosenLanes.asArray}

	explore{ ^ this.chosenLanesAsArray.inspect}


// ========TESTING  QUERYING========
noseConeIsInfinite{
		^this.noseCone == inf}

noseConeIsZero{
		^this.noseCone == 0}

hasPriorityBoarders {
			^ this.priorityBoarders.size>0}

hasTooManyPriorityBoarders{
		      ^ (this.priorityBoarders.size > noseCone)}

hasTimeChooser{
		^(this.timeChooser==nil).not
	}

hasActiveTimeChooser{
		^ this.hasTimeChooser.and( {this.timeChooser.isActive});
		}

lanesNotChosenYet{
		this.chosenLanes.isNil.if { "chosenLanes not  list - should not happen".postln; ^ true};
		^this.chosenLanes.isEmpty
	}

// ======  DERIVED COLLECTIONS AND NUMBERS ============
priorityBoarders {
			^ this.lanes.select({ arg eachLane, index; eachLane.hasInfiniteWeight})   }

finiteWeightedNonZeroLanes{
		^ this.lanes.select({arg eachLane, index ; (eachLane.hasInfiniteWeight.not).and({eachLane.hasZeroWeight.not}) } )   }

nonZeroWeightedLanes {
		var nzwl;
		nzwl = this.lanes.reject({ arg eachLane, index; eachLane.hasZeroWeight});
		^ nzwl
	}

noOfLanesStillToPick{
			   // only works with finite noseCone -
		       // and only relevant there - so only use it with finite ones
		this.noseConeIsZero.if { ^0};
		^  (this.noseCone -  this.chosenLanes.size)
			    // until we find out more about inf and nan
	                       }
chosenTimeLane {
		this.hasActiveTimeChooser.if (
			{	^ this.timeChooser.chosenLane},
			{  "No active time chooser2".postln; ^nil})
		    // what if none chosen yet?
		     // chooseLanes in this class  should makes sure it has been
		     // but program defensivley
	}


// ========    CHOOSING LANES  - Helper Methods    =================

	chooseWinnersFromTooManPriorityBoarders	 {
			| pool|
			 pool = this.priorityBoarders.copy;
			 noseCone.do ({ | choice|
				                     choice = pool.choose;
			                         this.chosenLanes.add (choice);
				                     pool.remove(choice)});
			^ this.chosenLanes}

chooseWinnersFromFiniteNonZeroWeightedLanes{
		     // needs this.chosenLanes to have been initialised by
		      // nonDeterministicLaneChoice
		     //  so maybe would be better if chosenLanes were a set
		var finiteNonZeroWeightedPool = this.finiteWeightedNonZeroLanes;
		 var pool = List.new;
		 var poolWeights = List.new;
		var  normalizedWeights;
		var noOfRemainingPicks;

		this.finiteWeightedNonZeroLanes.do({ arg eachLane; pool.add(eachLane);
			                      poolWeights.add(eachLane.weight)}); // initialize pool weights

		 noOfRemainingPicks = this.noOfLanesStillToPick;
		                  // being overly cautious - probably not needed
	     noOfRemainingPicks.do({  | choice|
	     normalizedWeights = poolWeights.asArray.normalizeSum; //need to normalize
			                                      choice = pool.asArray.wchoose(normalizedWeights);
			                                                    // wchoose only works for arrays
			 (choice==nil).if(
			{"Not enough non-zero weighted lanes to meet nosecone demand".postln;
					                                    // maybe adjust one or the other in response?
			});
			                                      chosenLanes.add(choice);
			                                      pool.remove(choice);

			                                        poolWeights = List.new;
// no need to remove chosen weight - just recreate weights for shrunken pool
			                                        pool.do ({ arg eachLane; poolWeights.add(eachLane.weight)});
			                                         })
			^ this.chosenLanes  }

// ========    CHOOSING LANES  - MAIN  METHODS   =================
nonDeterministicLaneChoice {
     	this.chosenLanes_(List.new);
		// Must be initialised here when this is called - not when creating the Xhooser
	   // 6 cases - zero noseCone
	this.noseConeIsZero.if ({ ^chosenLanes; }) ;//and we are out

	// infinite NoseCone
		this.noseConeIsInfinite.if ({
			       ^ this.chosenLanes_(this.nonZeroWeightedLanes) }) ;//and we are out

    // noseCone is not infinite but there are  too many priority boarders...
	this.hasTooManyPriorityBoarders.if({ this.chooseWinnersFromTooManPriorityBoarders;  ^ chosenLanes  });  // and we are out

	// Chooser does not have too many priority boarders
	//- so if there are any should add them all
	// but must go on next  to add any non zero weighted finite ones
	 this.hasPriorityBoarders.if({ chosenLanes.addAll(this.priorityBoarders) ;  });

     //  If no of priority boarders exactly matches number of seats, we are done
	    (this.noOfLanesStillToPick== 0).if({  ^ chosenLanes }) ; //and we are out

	//  make all (or any remaining) choices from from  solely finitely weighted lanes
		 ^ this.chooseWinnersFromFiniteNonZeroWeightedLanes
	         }


	chooseLanes{
		this.hasActiveTimeChooser.if {  this.timeChooser.chooseLane  }; // EXCELLENT
		this.nonDeterministicLaneChoice;
		this.cleanChosenLanes;
		this.hasActiveTimeChooser.if (
			{this.calculateSmartDurationWithChosenTimeLane},  // not needed to play it right - need for sequencing
			{this.calculateSmartDurationWithNoActiveTimeLane}); // not needed to play it right - need for sequencing

		this.chosenTimeLaneIsFullyPlayable.if {this.addPlayableTimeLaneToChosenLanes};
		^ this.chosenLanes
        // Lane not scheduled  or played yet - just chosen
		}



	cleanChosenLanes {
				this.chosenLanes.removeEvery(List[nil]);
		       this.chosenLanes.isEmpty.if{ this.chosenLanes.add(Lane.null)};
	}


// =========== PLAYABLE TIME LANES  ========================
	chosenTimeLaneIsFullyPlayable {
		this.hasActiveTimeChooser.not.if { "No active time chooser".postln; ^false};
		^ this.timeChooser.chosenLaneIsFullyPlayable
	}

	addPlayableTimeLaneToChosenLanes {
		this.hasActiveTimeChooser.and({this.chosenTimeLaneIsFullyPlayable}).if
		( { this.chosenLanes.add(this.timeChooser.chosenLane)}, {^ "No playableTimeLane available".postln})
	}


// =========== PLAYING  AND SCHEDULING =====================


playChosenLanes{  // doesn't choose fresh Lanes -  sticks with last choices
		          		       this.hasActiveTimeChooser.if (
		                         	{      this.journal.add( \hasActiveTimeChooser -> this.timeChooser);
				                            this.journal.add( \activeTimeLane -> this.chosenTimeLane);
				                           this.chosenLanes.do {|eachLane |
				                            eachLane.playWithChosenTimeLaneForParent(this.chosenTimeLane, this)}},
				                             {this.chosenLanes.do  { |eachLane | eachLane.play }     }  )
	                                }


play {                 //   multiple hits of plain play always produce new choices
		                  // journals previous choices,
			this.chooseLanes;                         // empties out previous choices
		    this.journal.add( \chosenLanes -> this.chosenLanes.asArray);
		    this.playChosenLanes                  // may be interesting if we go nested
	}



pause{
		this.chosenLanes.do  { |eachLane | eachLane.pause} }

resume{
		this.chosenLanes.do  { |eachLane | eachLane.resume} }

//========= DURATION =========

calculateSmartDurationWithChosenTimeLane {
	   this.chosenLanes.do {|eachLane |
	         eachLane.calculateSmartDurationWithChosenTimeLaneForParent(this.chosenTimeLane)}}

calculateSmartDurationWithNoActiveTimeLane{
	             this.chosenLanes.do {|eachLane |
	                     eachLane.calculateSmartDurationWithNoActiveTimeLane}}

duration{ // sequencer calls this to find out when to sequence
		this.lanesNotChosenYet.if {"No choices made yet - should not happen".postln; ^0};
	^	this.maxLaneDuration
	}


durationOfChosenTimeLane{                     //just  to lower coupling in lane
		^this.chosenTimeLane.duration
	}


maxLaneDuration{
		var durations;
		durations = chosenLanes.collect{ arg eachLane, i;     "smart duration of lane ".postln;
			                                                                             eachLane.smartDuration.postln;
			                                                                             eachLane.smartDuration};
		"durations.maxItem{arg item, i; item}".postln;
		durations.maxItem{arg item, i; item}.postln;
		^durations.maxItem{arg item, i; item}
	}


}

// PROTOCOL NEEDS CHECKING FOR UNNEEDED FLUFF & WARPING








	