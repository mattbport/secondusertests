SampleBank{
	classvar <>samples;
	classvar >tempo;

//=========  ALL CLASS METHODS  =====================

	*purge{ samples = nil; }

	*tempo{
		tempo.isNil.if {^ tempo = 122/60};  // NB Class (not instance)  holds global tempo
		^ tempo                                           // and acts as sample bank
	}

	*populate{
	    samples = Dictionary.new( n: 16); //  colon syntax is arg keyword
		                                                   //-based on how args declared
		samples.add(\guitar -> Sample.new(\guitar, "gtr8"));
		samples.add(\bass -> Sample.new(\bass, "bass4"));   // itry to get rid of redundant
		                                                                                   //repeated symbol parameter
		samples.add(\vox -> Sample.new(\vox, "vox8"));
		samples.add(\drums -> Sample.new(\drums ,"drums8"));

		samples.keysValuesDo { |eachKey, eachValue|   eachValue.init};
		"Wait before warming up".postln
	               }

	*warmUp{
		samples.keysValuesDo { |eachKey, eachValue|   eachValue.createSynthDef};
		          }

	*sampleDef{
			arg sampleSymbol;
		samples.isNil.if{  "SampleBank not Loaded - using non-playable proxy sample".postln
			^sampleSymbol};
			^ samples.atFail(sampleSymbol, {"playable not found".postln})
		       }

	*at{ arg aKey;
		this.samples.isNil.if{  "SampleBank not Loaded - please load first".postln; ^ aKey};
		this.samples.atFail(aKey, {"Sample not found".postln; ^ aKey});
		^this.samples.at(aKey)}



*secsToBeats{ arg secs;
	^ secs*  this.tempo }
	// samples should be exact numbers of beats & bars


*beatsToSecs{ arg beats;
	^ beats/ this.tempo }
	// samples should be exact numbers of beats & bars



       }
