//VERSION class-test-10.sc
//See notes at bottom of file

PlayableChooser {
var >lanes ,>weights,  >loops ,  >toplay, >nosecone, >mysynths,>laneDurations, <>laneDict;



init{
lanes = [1,2,3,4,5,6]; // up to six numbered samples available - HOW TO DEAL WITH NESTED?
		                         // 1-offset
weights = [999,2,2,2,3,1]; // 999 means 'a', or 'always play'
loops = [1,1,1,1,1,1]; // 1 means loop, 0 means dont loop - implemented by PlayBuf
		                          // 0-offset indices matched to  1-offset sample numbers by adding one
nosecone = [2,3,4].choose;
toplay = List.new; // chosen lanes, represented as collection of sample numbers 1-6
mysynths = [0,0,0,0,0,0,0]; // 7 of these,  hack due to 0-offset arrays and samples numbered 1-6
		                                   // zeroeth element should never be used
laneDurations= [999,999,999,999,999,999,999];// get overwritten with real durations
		                             //999 is hack so we can weed out  unset durations
    }

init2{
		// give this one different values
lanes = [1,2,3,4,5,6];
weights = [999,2,2,2,3,1]; // 999 means 'a', or 'always play'
loops = [1,1,1,1,1,1];
nosecone = [2,3,4].choose;
toplay = List.new; // start with no lane selection
mysynths = [0,0,0,0,0,0,0];
laneDurations= [999,999,999,999,999,999,999];
   }

init3{
		// give this one different values
lanes = [1,2,3,4,5,6];
weights = [999,2,2,2,3,1]; // 999 means 'a', or 'always play'
loops = [0,0,0,0,0,0];
nosecone = [2,3,4].choose;
toplay = List.new; // start with no lane selection
mysynths = [0,0,0,0,0,0,0];
laneDurations= [999,999,999,999,999,999,999];
   }

proto1{
		// dont play - just measure one chooser
	var fullChooser1;
	var fullChooser2;
	var fullChooser3;
	var pauseInBeats1;
	var pauseInBeats2;
	fullChooser1 = FullChooser.new;
	fullChooser1.with( PlayableChooser.new.init,  ClockChooser.new.init);
	fullChooser1.processWithoutPlaying;
	pauseInBeats1 = fullChooser1.calculatedDurationInBeats;
	}

proto2{
		// best demo - sequences three choosers correctly
	var fullChooser1;
	var fullChooser2;
	var fullChooser3;
	var pauseInBeats1;
	var pauseInBeats2;
	var pauseInBeats3;
		// first chooser
		"======== Construct & Measure FIRST Chooser ========".postln;
	fullChooser1 = FullChooser.new;
	fullChooser1.with( PlayableChooser.new.init,  ClockChooser.new.init);
	fullChooser1.processWithoutPlaying;
	 pauseInBeats1 = fullChooser1.calculatedDurationInBeats;
			"======== Construct & Measure SECOND Chooser ========".postln;
			// second chooser
	fullChooser2 = FullChooser.new;
	fullChooser2.with( PlayableChooser.new.init,  ClockChooser.new.init);
	fullChooser2.processWithoutPlaying;
	pauseInBeats2 = fullChooser2.calculatedDurationInBeats;
			"======== Construct & Measure THIRD Chooser ========".postln;
		// third chooser
	fullChooser3 = FullChooser.new;
	fullChooser3.with( PlayableChooser.new.init,  ClockChooser.new.init);
	fullChooser3.processWithoutPlaying;
	pauseInBeats3 = fullChooser3.calculatedDurationInBeats;

			"======== RUN FIRST Chooser ========".postln;
		// RUN first chooser
		fullChooser1.processWithExistingChoices;
		fullChooser1.calculatedDuration;
		"======== SCHEDULE SECOND  & THIRD Choosers ========".postln;
		//schedule
		TempoClock(fullChooser1.tempo).sched
	             ( pauseInBeats1 ,{fullChooser2.processWithExistingChoices;
			                                  "======== RUNNING FIRST SCHEDULED Chooser ========".postln;
		                                    fullChooser2.calculatedDuration; nil});
	    TempoClock(fullChooser2.tempo).sched
	          ( pauseInBeats1 + pauseInBeats2 ,{fullChooser3.processWithExistingChoices;
			                                     "======== RUNNING SECOND SCHEDULED Chooser ========".postln;
		                                                             fullChooser3.calculatedDuration; nil});

	 "======== INTERPRETER DONE - ALL SERVER NOW ========".postln;
	}

proto3{
		// more compact version of best demo - sequences three choosers correctly
	var fullChooser1;
	var fullChooser2;
	var fullChooser3;
		"======== Construct & Measure FIRST Chooser ========".postln;
		// first chooser
	fullChooser1 = FullChooser.new;
	fullChooser1.prepare( PlayableChooser.new.init,  ClockChooser.new.init);
			"======== Construct & Measure SECOND Chooser ========".postln;
			// second chooser
	fullChooser2 = FullChooser.new;
	fullChooser2.prepare( PlayableChooser.new.init,  ClockChooser.new.init);
		                                                  // give me different inits
			"======== Construct & Measure THIRD Chooser ========".postln;
		// third chooser
	fullChooser3 = FullChooser.new;
	fullChooser3.prepare( PlayableChooser.new.init,  ClockChooser.new.init);
		                                                    // or use nil instead of the clock chooser etc
			"======== RUN FIRST Chooser ========".postln;
		// RUN first chooser
		fullChooser1.processFullyWithExistingChoices;

		"======== SCHEDULE SECOND  & THIRD Chooser ========".postln;
		//schedule second and third choosers
		TempoClock(fullChooser1.tempo).sched
	             ( fullChooser1.nextPauseInBeats,
			        { "====== RUNNING FIRST SCHEDULED Chooser ======".postln;
			                          fullChooser2.processFullyWithExistingChoices; nil});

	    TempoClock(fullChooser2.tempo).sched
		         ( fullChooser1.nextPauseInBeats + fullChooser2.nextPauseInBeats,
			{ "======RUNNING SECOND SCHEDULED Chooser =======".postln;
				                      fullChooser3.processFullyWithExistingChoices; nil});

           "=====INTERPRETER DONE - ALL RUNNING ON SERVER NOW ======".postln;
}





demo1{
	// just one chooser
	// bit silly that this is a method of Playable Chooser,  not  a big problem
	// but better as a method of FullChooser
	var fullChooser;
	var pauseInBars;
	fullChooser = FullChooser.new;
	fullChooser.with( PlayableChooser.new.init,
			                   ClockChooser.new.init);
	fullChooser.process;
	  pauseInBars = fullChooser.calculatedDuration;
	}


demo3{
	// No clock lane
	var fullChooser;
	var pauseInBars;
	fullChooser = FullChooser.new;
	fullChooser.with( PlayableChooser.new.init,  nil);
	fullChooser.process;
     pauseInBars = fullChooser.calculatedDuration;
	}

demo4{
	var fullChooser;
	var pauseInBars;
	fullChooser = FullChooser.new;
	fullChooser.with( PlayableChooser.new.init,  ClockChooser.new.init2);
	fullChooser.process;
	fullChooser.calculatedDuration
	}

demo5{
	var fullChooser;
	var pauseInBars;
	fullChooser = FullChooser.new;
	fullChooser.with( PlayableChooser.new.init3,  ClockChooser.new.init4);
	fullChooser.process;
	fullChooser.calculatedDuration
	}

demo6{
	var fullChooser;
	var pauseInBars;
	fullChooser = FullChooser.new;
	fullChooser.with( PlayableChooser.new.init,  ClockChooser.new.init5);
	fullChooser.process;
	fullChooser.calculatedDuration
	}


play{
	var fullChooser;
	fullChooser = FullChooser.new;
	fullChooser.with( this,  nil);
	fullChooser.process;
		fullChooser.calculatedDuration}



noseCone{ ^nosecone}

toplay{
		^ toplay  } // chosen lanes, represented as collection of sample numbers 1-6

mysynths{
		^ mysynths }

laneDurations{
		^ laneDurations  }

loops{
		^ loops    }         // 1 means loop, 0 means dont loop - implemented by PlayBuf
		                          // 0-offset indices matched to  1-offset sample numbers by adding one

chosenSynths{
^ this.mysynths.select({arg each; each.isInteger.not})}


chosenDurations{
		^ this.laneDurations.select({arg each; (each==999).not })}

chosenLaneDurationsAsBars{
		^ this.chosenDurations.collect({arg each; each })}

maxChosenSampleDuration{
		var i;
		i= this.chosenDurations.maxIndex;
		^ this.chosenDurations[i]}


checkNoseCone{
// check to see if the nosecone allows for playback
	if (nosecone > 0,
		{
// check to see if the A weight count is greater than the nosecone number
// if it is, increase the nosecone number to allow all to play
		 if (weights.occurrencesOf(999) > nosecone ,
			{
			nosecone = weights.occurrencesOf(999);
			"Too many 'A' lanes. Nose cone now set to ".post;
			nosecone.postln;
			},
			{});
// check to see if the nose cone > number of lanes
// if so, change nose cone value to the number of lanes
		if (
			lanes.count({arg item, i; item.isPositive}) < nosecone ,
			{nosecone = lanes.count({arg item, i; item.isPositive});
	"Nose cone value too high. Nose cone now set to ".post;
	nosecone.postln; },
			 {});
       ^ nosecone
	     },
			{"Zero in nose cone of playable ".postln; ^0 });
      }


	chooseLanes{
		var weightindex, chosen, chosenlocation, selectlane;
		for (1, nosecone, {
		   if (weights.includes(999), {
				weightindex = weights.indexOf(999);
				// index of the 999 weight
				chosen = lanes[weightindex];
				// use the index to get the lane number of the 999 weight lane
				toplay = toplay.add(chosen);
				// add the chosen value to the 'toplay' array
				lanes.remove(lanes[weightindex]);
				// prevent reselection by removing chosen value from initial list
				weights.remove(weights[weightindex]);
				// remove corresponding weights of the chosen value
		},
		{
			selectlane = { lanes.wchoose(weights.normalizeSum) };
				// Select a lane
			chosen = selectlane.value;
				// add the selected value to the variable 'chosen'
			chosenlocation = lanes.indexOf(chosen);
				// get the location of the 'chosen' value
			toplay = toplay.add(chosen);
				// add the chosen value to the 'toplay' array
			lanes.remove(lanes[chosenlocation]);
				// prevent reselection by removing chosen value from initial list
			weights.remove(weights[chosenlocation]);
				// remove corresponding weights of the chosen value
	})
				}
);
	}

postPlayableSelections{
		  "Playable Nose cone =  ".post;  this.noseCone.postln;
		  "Chosen lanes: ".post; toplay.postln;
	      //"Chosen Synths: ".post;this.chosenSynths.postln;
		  "Chosen Loops: ".post;this.chosenLoops.postln;
		 }

playLanes{
     "Playing lanes: ".post; toplay.postln;

		if (toplay.includes(1), { mysynths.put(1, Synth(\drums, [\loop, loops[0]])) }, {} );
		if (toplay.includes(2), { mysynths.put(2, Synth(\bass, [\loop, loops[1]]))}, {} );
		if (toplay.includes(3), { mysynths.put(3, Synth(\guitar, [\loop, loops[2]])) }, {} );
		if (toplay.includes(4), { mysynths.put(4, Synth(\bv, [\loop, loops[3]]))}, {} );
		if (toplay.includes(5), { mysynths.put(5, Synth(\marimba, [\loop, loops[4]]))}, {} );
		if (toplay.includes(6), { mysynths.put(6, Synth(\vox, [\loop, loops[5]])) }, {} );
	}

measureLaneDurations{
		if (toplay.includes(1), { laneDurations.put(0, ~sampleDurations[0]) }, {} ); // SEE zero offset!
		if (toplay.includes(2), { laneDurations.put(1,  ~sampleDurations[1]) }, {} );
		if (toplay.includes(3), { laneDurations.put(2,  ~sampleDurations[2])  }, {} );
		if (toplay.includes(4), { laneDurations.put(3,  ~sampleDurations[3] ) }, {} );
		if (toplay.includes(5), { laneDurations.put(4,  ~sampleDurations[4] ) }, {} );
		if (toplay.includes(6), { laneDurations.put(5,  ~sampleDurations[5])  }, {} );

		// use of  ~sampleDurations is a  hack - good if can find another way of getting
		// durations of samples
		//"Sample durations: " .post; laneDurations.postln;
	}

isLooper{arg i;
		// NB works with 1-offset arguments, not zero-offset arguemnts
		if(i<1,{^false},{});// just error checks
		if(i> this.loops.size,{^false},{});  // just error check
		if(this.loops[i-1] == 1, {^true},{});
		if(this.loops[i-1] == 0, {^false},{});
	}

chosenContainsLoop{
			^this.toplay.any({arg eachSampleNumber,i; this.isLooper(eachSampleNumber )})
      }


chosenLoops{
			^this.toplay.collect({arg eachSampleNumber; this.isLooper(eachSampleNumber )})

}
}
//================================================
//================================================

ClockChooser {
var >timelanes, <>timenosecone,>beatsperbar,>durationinbars,>timeweights, >softstop, >winningduration, >timechosen, >timechosenlocation, >timeselectlane,>tempo, <>lanes, <>laneDict ;

init{
timelanes = [0,1,2,3]; // WAS [1 ,2,3,4] - nasty zero /one offset bug
timenosecone = 1;
beatsperbar = [4,4,4,4];
durationinbars = [2,4,8,6];
timeweights = [1,1,1,1];
softstop = [1,0,0,1];
winningduration = nil;
tempo = 122/60;
}

init2{
// give this one different values
timelanes = [0,1,2,3]; // WAS [1 ,2,3,4]
timenosecone = 2;
beatsperbar = [4,4,4,4];
durationinbars = [2,4,8,6];
timeweights = [1,1,1,1];
softstop = [1,0,0,1];
winningduration = nil;
tempo = 122/60;
}

init3{
// give this one different values
		timelanes = [0,1,2,3]; // WAS [1 ,2,3,4]
timenosecone = 1;
beatsperbar = [4,4,4,4];
durationinbars = [2,4,8,6];
timeweights = [1,1,1,1];
softstop = [1,1,1,1];
winningduration = nil;
tempo = 122/60;
}

init4{
// give this one different values
		timelanes = [0,1,2,3]; // WAS [1 ,2,3,4]
timenosecone = 0;
beatsperbar = [4,4,4,4];
durationinbars = [2,4,8,6];
timeweights = [1,1,1,1];
softstop = [1,1,1,1];
winningduration = nil;
tempo = 122/60;
}

init5{
// give this one different values
timelanes = [0,1,2,3]; // WAS [1 ,2,3,4]
timenosecone = 0;
beatsperbar = [4,4,4,4];
durationinbars = [2,4,8,6];
timeweights = [1,1,1,1];
softstop = [1,1,1,1];
winningduration = nil;
tempo = 122/60;
}

winningDuration{
		^ winningduration}

durationsInBars{
		^ durationinbars}

timeNoseCone{
		^ timenosecone}

beatsperbar{
		^ beatsperbar }

timechosen{
		^ timechosen}

timeselectlane{
		^ timeselectlane}

winningduration{
	^winningduration}

tempo{
		^ tempo}

chosenBeatsPerBar{
	^beatsperbar[timechosen]}

secsToBeats{ arg secs;
	^ secs*  this.tempo }
	// samples should be exact numbers of beats & bars

secsToBars{arg secs;
		//this.chosenBeatsPerBar.postln;
	^ this.secsToBeats(secs)/ this.chosenBeatsPerBar}

isHardStop{
		^ softstop[timechosenlocation] < 1}

isSoftStop{
		^ this.isHardStop.not}

	//bit of three way duplication here
chooseClockLaneAndManageStops{ arg playableChooser, fullChooser;
		this.chooseClockLane(playableChooser, fullChooser);
		this.manageStops(playableChooser, fullChooser);}

silentRestDuration{
		this.chooseClockLaneSilent;
		if( this.timenosecone == 0,
			{ "zero in clock chooser nose cone so no delay".postln; ^ 0; },
			{ ^ this.winningDuration }
		)
	}

chooseClockLane{ arg playableChooser, fullChooser;
		// in the wrong class - this and what it calls should be in FullChooser
		// this passing of the full chooser as argument  is calling out for refactoring
		timeselectlane = { timelanes.wchoose(timeweights.normalizeSum) }; //weighted choice
		//"*** timeselectlane: ".post; timeselectlane.postln;
		timechosen = timeselectlane.value; // needed to evaluate the closure  -gives the INDEX (NB 1-offset !!!!!)
		//"*** timeselectlane.value: ".post; timeselectlane.value.postln;
		timechosenlocation = timelanes.indexOf(timechosen); //ZERO OFFSET??
		winningduration = durationinbars[timechosenlocation]; }


chooseClockLaneSilent{
		// in the wrong class - this and what it calls should be in FullChooser
		// this passing of the full chooser as argument  is calling out for refactoring
		timeselectlane = { timelanes.wchoose(timeweights.normalizeSum) }; //weighted choice
		//"*** timeselectlane: ".post; timeselectlane.postln;
		timechosen = timeselectlane.value; // needed to evaluate the closure  -gives the INDEX (NB 1-offset !!!!!)
		//"*** timeselectlane.value: ".post; timeselectlane.value.postln;
		timechosenlocation = timelanes.indexOf(timechosen); //ZERO OFFSET??
		winningduration = durationinbars[timechosenlocation]; }



manageStops{ arg playableChooser, fullChooser;
		if ( timenosecone < 1,
			{"No time master, no hard or soft stop".postln; ^ winningduration = 999},

			{ if (softstop[timechosenlocation] < 1,
				   { ^this.hardStopAfterBars(winningduration,
					                                     fullChooser,)},
				   { ^this.softStopAfterBars(winningduration, fullChooser)}
			     );
            }
	)
}

softStopAfterBars{ arg bars, aFullChooser;
		// NB - the useful soft stop calculations prototyped here are only used toswitch loop off
		// for other soft stop actions see calculatedDuration
		var  maxIndex;
		var  maxSampleDuration;
		var  maxSampleDurationInBars;
		var maxOverallDuration;
		var aPlayableChooser;
		aPlayableChooser = aFullChooser.playableChooser;

		"**Chooser will SOFT STOP after ".post; bars.post; " bars".postln;
		"Synths to softstop: ".post; aPlayableChooser.chosenSynths.postln;
		"Sample durations: ".post; aPlayableChooser.chosenDurations.postln;
		"Sample durations in beats : ".post;
		      aFullChooser.chosenSampleDurationsInBeats.postln;
		"Sample durations in bars : ".post;
		      aFullChooser.chosenSampleDurationsInBars.postln;

		  // "Max index: ".post; aPlayableChooser.chosenDurations.maxIndex.postln;
		 maxIndex = aPlayableChooser.chosenDurations.maxIndex;
		     //   "max sample duration: ".post; aPlayableChooser.chosenDurations[maxIndex].postln;
		 maxSampleDuration = aPlayableChooser.chosenDurations[maxIndex];
		 maxSampleDurationInBars = aFullChooser.chosenSampleDurationsInBars[maxIndex];
		maxOverallDuration = bars.max(maxSampleDurationInBars);

		// "maxOverallDuration in bars: ".post; bars.max(maxSampleDurationInBars).postln;
		// These are all useful calculations but not fully used here
		//  I THINK THIS SEMANTICS IS WRONG!!!!!!!
		//  At PRESENT,  if there is a  SOFT STOP, SWITCHES off all loops immedialtely,
		  // but what should do isschedule the switch of each short loop for a time just after
		//   ((duration of longestLoop) modulo (duration of each shorter loop)) rounded down
		// this would not be at all hard.
		  aPlayableChooser.chosenSynths.do(
			{arg eachSynth; // eachSynth.postln;
				                     eachSynth.set(\loop, 0);});

		    "Loops turned off now".postln;

		   ^maxOverallDuration;
}


hardStopAfterBars{ arg bars, aFullChooser;
	var aPlayableChooser;
	var beats;
	var secs;
	var timeNow;
	var t;
	beats =  bars*this.chosenBeatsPerBar;
	secs = beats/this.tempo;
	aPlayableChooser = aFullChooser.playableChooser;
		"**Chooser will HARD STOP in ".post; bars.post; " bars".postln;
		"-Which is ".post;beats.post; " beats".postln;
		"-Or ".post; secs.post; " seconds".postln;
		"-At tempo ".post; this.tempo.postln;
		// USES SCHEDULER TO SCHEDULE A HARD STOP
		// IS THIS SEMANTICS right?
		// if a hard stop is scheduled
		// and if all of the chosen semples happen to be shorter than that and not looping
		// at present it waits for the hard stop - whereas it probably it should stop right there
		t =   TempoClock(this.tempo);
        t.sched( beats,
			 { "Schedule synths to hard stop: ".post; aPlayableChooser.chosenSynths.postln;
				aPlayableChooser.chosenSynths.do(
					{arg eachSynth; eachSynth.free; eachSynth.post; " freed". postln});
		      });
	^secs //  this return value probably not used
	}

		postClockSelections{
		"Available stop durations: ".post; this.durationsInBars.postln;
		"Chosen stop duration index: ".post; this.timechosen.postln;
		"Chosen stop duration in bars: ".post; this.winningDuration.postln;
		"Chosen stop type: ".post;   if(this.isHardStop, {"hard stop".postln},{"soft stop".postln});
		 }




}

//================================================
//================================================


FullChooser {
var <>playableChooser;
var <>clockChooser;
var duration;  // is this currently acted on or bypassed?
	                  // I think ignored  - see >>process and >>duration
var maxSampleDurationInBars;
var nextPauseInBeats;
var <>trainNumber;

//var <>sampleDurationsInBeats;
// var <>sampleDurationsInBars;

play{
		this.process}

hasClockChooser{
		^ (this.clockChooser != nil)}

globalBeatsPerBar{
		^ ~globalBeatsPerBar}

globalTempo{
		^ ~globalTempo}

nextPauseInBeats{
		^ nextPauseInBeats}

nextPauseInBeats_{ arg num;
		nextPauseInBeats = num}


chosenSampleDurationsInSecs{
		^ this.playableChooser.chosenDurations
		}

chosenSampleDurationsInBeats{
		^ this.chosenSampleDurationsInSecs.collect({arg each;this.secsToBeats (each)})
		}

chosenSampleDurationsInBars{
		^ this.chosenSampleDurationsInSecs.collect({arg each;this.secsToBars (each)})
		}


chosenBeatsPerBar{
		if( this.hasClockChooser,
			   {^this.clockChooser.chosenBeatsPerBar},
			   {^this.globalBeatsPerBar }	)}

secsToBeats{arg secs;
		if(this.hasClockChooser,
			{ ^this.clockChooser.secsToBeats(secs)},
			{ ^this.globalSecsToBeats(secs) });}

secsToBars{arg secs;
		if(this.hasClockChooser,
			{ ^this.clockChooser.secsToBars(secs)},
			{ ^this.globalSecsToBars(secs) });}

globalSecsToBeats{arg secs;
		^ this.globalTempo * secs}

globalSecsToBars{arg secs;
		^  (this.globalTempo * secs) / this.globalBeatsPerBar  }

anyTrackLoops{
		^ this.playableChooser.chosenContainsLoop}

barsOfLongestLane{
		^ this.secsToBars (playableChooser.maxChosenSampleDuration)}

with {arg playable, clock;
		playableChooser = playable;
		clockChooser = clock;
	}

prepare {arg playable, clock;
		this.with(playable, clock);
		this.processWithoutPlaying}

makeReady{
		this.prepare(this.playableChooser, this.clockChooser);
	   ^ this}


tempo{
		if( this.hasClockChooser,
			   {^this.clockChooser.tempo},
			   {^this.globalTempo }	)}

doClocksWithExistingChoices{   // DUPLICATION - 3 related version sof this method
		if( clockChooser==nil,{  ^ "Done"},{});
		^ clockChooser.manageStops(playableChooser,this) ;}

doClocks{
		if( clockChooser==nil,{this.calculatedDuration; ^ "Done"},{});
		^ clockChooser.chooseClockLaneAndManageStops(playableChooser,this) ;}


selectClocks{
		if( clockChooser==nil,{this.calculatedDuration; ^ "Done"},{});
		^ clockChooser.chooseClockLane(playableChooser,this) ;}


hasClock{
		if (clockChooser == nil, {^ false}, {});
		if (clockChooser.timeNoseCone<1, {^ false}, {^true})}

longestSampleDuration{
		^ this.playableChooser.maxChosenSampleDuration}

hasHardStop{
		^ this.clockChooser.isHardStop}
hasSoftStop{
		^ this.clockChooser.isSoftStop}

basicStopDuration{
		^this.clockChooser.winningduration}

samplesShorterThanStop{
		^ this.longestSampleDuration < this.basicStopDuration}

softStopDuration{
		^ if( this.samplesShorterThanStop, {^this.longestSampleDuration},{^this.basicStopDuration})}

//calculatedDuration{
	// Algorithm in psudocode
	 // if no clock
	 	// if any track  loops
		    // ^ duration = 999 (or infinity if available)
		// if no tracks loop
		   // ^ duration of longest lane
	//if there is a clock
		   // if no tracks loop
		       // if duration of longest lane < duration of stoptime
		           // ^ duration of longest lane
		// if hard stop
		   //  ^ duration = duration of hard stop
	   //If soft stop
		    // if duration of sample in any looped lane > duration of stop
		                 // ^ duration of longest of those samples
		      // otherwise just return winning duration


calculatedDurationInBeats{
		var bars;
		var beats;
		var secs;
		bars= this.calculatedDuration;
		beats =  bars*this.chosenBeatsPerBar;
		secs = beats/this.tempo;
		"NEXT CHOOSER will start up in ".post; bars.post; " bars".postln;
		"-Which is ".post;beats.post; " beats".postln;
		"-Or ".post; secs.post; " seconds".postln;
		"-At tempo ".post; this.tempo.postln;
		^beats}




calculatedDuration{
	 " CALCULATED DURATION in bars... ".postln;
		if (this.playableChooser.noseCone ==0, // avoiding re-running checknosecone - creates confusing messages
			        {"Zero in soundable nose cone, silent rest".postln;  ^ this.clockChooser.silentRestDuration},
				    { "we dont have that problem - carry on"});
	 // if no clock
		if(this.hasClock.not,
			{ "-Chooser has no clock ".postln ;
				if(this.anyTrackLoops,
				           { "- Also there is a loop - so infinite duration ".postln; ^999},
				           { "- But no track loops - so duration in bars of longest lane ".post ;
						      this.barsOfLongestLane.postln;
						     ^this.barsOfLongestLane})},
			{"-Chooser has clock ".postln } );
		// if we havent returned yet, then there is a clock- so onto other cases
		if(this.anyTrackLoops.not,
			{ "-No tracks loop ".postln;
			  if (this.barsOfLongestLane < this.basicStopDuration,
				{ "-Longest lane is shorter than stop duration ".postln;
				"-Bars of longest lane ".post; this.barsOfLongestLane.postln;
						"-Basic stop duration ".post; this.basicStopDuration.postln;
					^ this.barsOfLongestLane },
					{ "-Longest lane is longer than or equal to stop duration ".postln;})},
			{"-At least one track has loop ".postln;});
       // if we havent returned yet,  then there is a loop- so onto other cases
		if(this.hasHardStop, {   "-Has hard stop with duration ".post;
			                               this.basicStopDuration.postln;
			                              ^this.basicStopDuration},
		                                { "-Must be a softstop ".postln;
			                               "-But there is a loop, so ".postln;
			                               "-Duration is longest loop ".postln;
			                               "-Which has duration ".post;
			                                this.barsOfLongestLane.postln;
		                                    ^ this.barsOfLongestLane});
	// if we havent returned yet,  its a soft stop
		 if(this.hasSoftStop,{"-Soft stop duration  ".post; this.softStopDuration.postln;
			                                 ^ this.softStopDuration},{});

		"ARE THERE ANY CASES THAT FALL DOWN TO HERE? NOT YET ".postln;
		      // otherwise just return winning duration - currently ignored
	^duration}


processWithoutPlaying{        //  NB  EVIL DUPLICATION!!!! - NEAR DUPLICATE OF process
		if ((playableChooser.checkNoseCone > 0) ,
			{    "Playable nose cone value is > 0".postln;
				"about to choose lane".postln;
				 playableChooser.chooseLanes;
				"lane durations".postln;
				playableChooser.measureLaneDurations;
				"duration equals".postln;
			     duration = this.selectClocks;
				 this.postSelections;
				this.nextPauseInBeats_(this.calculatedDurationInBeats);
			},  // DIFFERENT HERE - one deleted line & 1 altered line
		{       "Playable nose cone check = 0".postln;
				this.nextPauseInBeats_(this.calculatedDurationInBeats);
				duration = 0; "Chooser skipped due to zero in playable nose cone".postln}); }


processFullyWithExistingChoices{
		this.processWithExistingChoices;
		this.calculatedDuration;}

processWithExistingChoices{
		if ((playableChooser.checkNoseCone >=0) ,
			  {    playableChooser.playLanes;
				         // starts playing here - interesting that clock lane comes later
			     duration = this.doClocksWithExistingChoices;
			  },
		      {       "Playable nose cone check >= 0".postln;
				duration = 0; "Chooser skipped due to zero in playable nose cone".postln});
		           // does anyone pay attention to duration ? No - see hardstop, softstop & calculateDuration
		    }



process{
		if ((playableChooser.checkNoseCone >=0) ,
			{    "Playable nose cone value is >0".postln;
				 playableChooser.chooseLanes;
				playableChooser.measureLaneDurations;
			     playableChooser.playLanes;
				         // starts playing here - interesting that clock lane comes later
			     duration = this.doClocks;

			},          // now  works right if no clock lane at all
		{       "Playable nose cone check >= 0".postln;
				duration = 0; "Chooser skipped due to zero in playable nose cone".postln}); }
	         // does anyone pay attention to duration ? No - see hardstop, softstop & calculateDuration


processWithBeatOffset{ arg pauseInBeats, oldTempo;
	TempoClock(oldTempo).sched( pauseInBeats,
			{   " ".postln; "FIRING UP SEQUENCED CHOOSER ".postln;
				" with pause of ".post; pauseInBeats.post;  " seconds".postln;
				this.process;
				nextPauseInBeats= this.calculatedDurationInBeats; nil
				 // ends in nil  because sched loops if function  ends with a number!!!
		      });   }

	postSelections{
		var bars;
		var max;
		"CHOICES SUMMARY ====".postln;
		this.playableChooser.chosenDurations.postln;
		bars = this.playableChooser.chosenDurations.collect({ arg each;
		this.secsToBars(each)});
		max = this.secsToBars(this.playableChooser.maxChosenSampleDuration);
		 this.playableChooser.postPlayableSelections;
		"Chosen lane durations in bars: ".post; bars.postln;
		"Max lane duration in bars: ".post; max.postln;
		if(this.clockChooser == nil, {"No clockChooser".postln},
			{this.clockChooser.postClockSelections});
		" END OF CHOICES SUMMARY====".postln;
		}

}



Maker{
var <>lanes ,<>weights,  <>loops ,  <>toplay, <>nosecone, <>mysynths,<>laneDurations,
<>timelanes, <>timenosecone,<>beatsperbar,<>durationinbars,<>timeweights, <>softstop, <>winningduration, <>timechosen, <>timechosenlocation, <>timeselectlane, <>tempo,
<>playableChooser, <>clockChooser, <>fullChooser, <>noClockChooser;


	// 1 drums
	// 2 bass
	// 3 guitar
	// 4 BVs
	// 5 marimba
	// 6 vocals


	// Scenario 1
scenario1{
lanes = [1,2];
weights = [1,1]; // 999 means 'a', or 'always play'
loops = [0,0,0,0,0,0]; // currently needs to always be set to size of 6
nosecone = 1;
//===========
timelanes = [0,1]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4,4];
durationinbars = [4];
timeweights = [1];
softstop = [0,0];
tempo = 122/60;
noClockChooser=true;
}

	// Scenario 2
	// drums, bass, guitar
scenario2{
lanes = [1,2,3];
weights = [999,1,1]; // 999 means 'a', or 'always play'
loops = [1,1,1,0,0,0]; // currently needs to always be set to size of 6
nosecone = 2;
//===========
timelanes = [0,1]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4,4];
durationinbars = [4];
timeweights = [1];
softstop = [0,0];
tempo = 122/60;
noClockChooser=true;
}

	// There is no playable Scenario 3


	// Scenario 4
	// drums, bass, guitar with set duration
scenario4{
lanes = [1,2,3];
weights = [999,1,1]; // 999 means 'a', or 'always play'
loops = [1,1,1,0,0,0]; // currently needs to always be set to size of 6
nosecone = 2;
//===========
timelanes = [0]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4];
durationinbars = [4];
timeweights = [1];
softstop = [0,0];
tempo = 122/60;
noClockChooser=false;
}


	// Scenario 5
	// drums, bass, marimba
scenario5{
lanes = [1,2,5];
weights = [3,2,1]; // 999 means 'a', or 'always play'
loops = [1,1,1,1,1,1]; // currently needs to always be set to size of 6
nosecone = 3;
//===========
timelanes = [0]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4];
durationinbars = [8];
timeweights = [1];
softstop = [0];
tempo = 122/60;
noClockChooser=false;
}


	// Scenario 6
	// guitar 3, BVs 4, vox 6

scenario6{
lanes = [3,4,6];
weights = [999,999,999]; // 999 means 'a', or 'always play'
loops = [1,1,1,1,1,1]; // currently needs to always be set to size of 6
nosecone = 3;
//===========
timelanes = [0,1]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4,4];
durationinbars = [8,16];
timeweights = [1,2];
softstop = [0,1];
tempo = 122/60;
noClockChooser=false;
}



		// Scenario 7
	// drums and bass always play, loop - 1 and 2
	// guitar and vocals - guitar twice as likely - not loop
	// 2 bar hard, 4 bar soft, 5 bar hard - 2 bar twice as likely

	// 1 drums
	// 2 bass
	// 3 guitar
	// 4 BVs
	// 5 marimba
	// 6 vocals


scenario7{
lanes = [1,2,3,6];
weights = [999,999,2,1]; // 999 means 'a', or 'always play'
loops = [1,1,0,1,1,0]; // currently needs to always be set to size of 6
nosecone = 3;
//===========
timelanes = [0,1,2]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4,4,4];
durationinbars = [2,4,5];
timeweights = [2,1,1];
softstop = [0,1,0];
tempo = 122/60;
noClockChooser=false;
}




	// 1 drums
	// 2 bass
	// 3 guitar
	// 4 BVs
	// 5 marimba
	// 6 vocals

init{
lanes = [1,2,3];
weights = [999,1,1]; // 999 means 'a', or 'always play'
loops = [0,0,0,0,0,0]; // currently needs to always be set to size of 6
nosecone = 2;
//===========
timelanes = [0,1]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4,4];
durationinbars = [4,8];
timeweights = [1];
softstop = [0,0];
tempo = 122/60;
noClockChooser=false;
}

	init2{
lanes = [1,5];
weights = [1,1]; // 999 means 'a', or 'always play'
loops = [1,1,1,1,1,1]; // always set to size of 6
nosecone = 1;
//===========
timelanes = [0,1,2,3]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4,4,4,4];
durationinbars = [2,3,4,6];
timeweights = [2,5,1,1];
softstop = [1,0,0,1];
tempo = 122/60;
noClockChooser=false;
}


init3{
lanes = [2,1,6,5];
weights = [1,999,999,1]; // 999 means 'a', or 'always play'
loops = [1,1,0,1];
nosecone = 3;
//===========
timelanes = [0,1,2]; // NOT [1 ,2,3,4]
timenosecone = 1; // number in clocknoseclone
beatsperbar = [4,4,4];
durationinbars = [4,8,6];
timeweights = [2,2,1];
softstop = [0,0,1];
tempo = 122/60;
noClockChooser=false;
}


make{
	this.playableChooser_ (PlayableChooser.new);
	this.fullChooser_(FullChooser.new);
	this.playableChooser.lanes_(this.lanes);
	this.playableChooser.weights_(this.weights);
	this.playableChooser.loops_(this.loops);
	this.playableChooser.nosecone_(this.nosecone);
	//==========
	this.playableChooser.toplay_(List.new);
	this.playableChooser.mysynths_( [0,0,0,0,0,0,0]); //  0th element  never  used
	this.playableChooser.laneDurations_( [999,999,999,999,999,999,999]);
	//==========

	if(noClockChooser,{},{
     this.clockChooser_(ClockChooser.new);
	this.clockChooser.timelanes_(this.timelanes);
    this.clockChooser.timenosecone_(this.timenosecone);
    this.clockChooser.beatsperbar_(this.beatsperbar);
	this.clockChooser.durationinbars_(this.durationinbars);
	this.clockChooser.timeweights_(this.timeweights);
	this.clockChooser.softstop_(this.softstop);
	this.clockChooser.tempo_(this.tempo);});

	this.fullChooser_( FullChooser.new.with( this.playableChooser,  this.clockChooser));
	^this.fullChooser;
	}

    }


Train{
	var <>choosers;

*new1{
		var me;
		^ super.new.init;}

init{ choosers = List.new;}

add{arg aFullChooser;
	this.choosers.add(aFullChooser);}

addAll{arg aList;
	this.choosers.addAll(aList);}

schedule{arg aPauseInBeats, aFullChooser;
		TempoClock(aFullChooser.tempo).sched
		( aPauseInBeats,{ "======== RUNNING CHOOSER NUMBER ".post;
			                         aFullChooser.trainNumber.post;
			                       "===========".postln;
			                           aFullChooser.processFullyWithExistingChoices; nil});}

play{ var count;
		count = 0;
		choosers.do({ arg eachChooser; eachChooser.makeReady});
		choosers.inject(0,{|  thisPauseInBeats, nextChooser|
				                        count = count +1;
			                            nextChooser.trainNumber_(count);
			                            "=== SCHEDULE  Chooser No:".post;
			                            count.post;
				                         " ========".postln;
			                            this.schedule(thisPauseInBeats, nextChooser;);
			                            thisPauseInBeats+ nextChooser.nextPauseInBeats};);
	 "=====INTERPRETING DONE - ALL RUNNING ON SERVER NOW ======".postln;
			                     }

				// inject.
				//  provide  a starting value for the compuation then
				// the thing returned from each iteration of the inject
				// becomes the next input into the inject
				//  crucially allows result of current computation to be interacted with result of previous
				//at each step. works a treat here for accumulating the pause

      }




Chooser {
	// later this could perhaps be abstracted out as superclass of various chooser classes
}


// POSSIBLE Later refactors & Fixes
// 1/  Key demo is PlayableChooser>> proto2 or proto3
//        seems good enough to support most initial experiments
// 2/ Possibly two slightly wrong semantics that could easily be fixed
//     for details (search code for "SEMANTICS"
// 3/ the way in which duration information is taken from samples
//      is clumsy - could be improved or  cached
//       namely  ~sampleDurations
//      is there some other way?
// 4/ test changing tempo between choosers......
// 5/ should be able to deal with open ended samples - though ok for experiment
// 6/ should be able to deal with nesting - though OK for experiment
// 7/ see PlayableChooser >> playlanes and PlayableChooser >> init
           // too much  mixing of  1 offset &  0 offset in all the arrays
          // works but is confusing
// 8/ no actual lane concept - approximated here as sample
//       probably means need another refactor to do nesting -  might not be too hard
// 9/ ideally apply camel case uniformly
// 10/ would be handy to have suite of unit tests
