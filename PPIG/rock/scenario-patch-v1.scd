//VERSION z-test-9.scd
// Note that my version has to use different file paths
// and (for convenience only) I am using  ~mySamples,  which is of course not essential
// however  use of ~sampleDurations  = [~drums.duration, ~bass.duration, ~guitar.duration,
//                      ~bv.duration,  ~marimba.duration,  ~vox.duration]
// is currently essential, though we need a better way to get duration of samples

(
~mySamples= {
(
~drums = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/drums8.wav");
~bass = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/bass4.wav");
~bass2 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/bass8.wav");
~guitar = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/gtr8.wav");
~marimba = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/marimba4.wav");
~bass3 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/synthbass4.wav");
~bv = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/bv8.wav");
~vox = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/vox8.wav");

SynthDef(\drums, { arg loop=0, volume=0.4;
	Out.ar(0,
		PlayBuf.ar(2, ~drums.bufnum, BufRateScale.kr(~drums.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\bass, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~bass.bufnum, BufRateScale.kr(~bass.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\bass2, { arg loop=0, volume=0.3;
	Out.ar(0,
		PlayBuf.ar(2, ~bass2.bufnum, BufRateScale.kr(~bass2.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\guitar, { arg loop=0, volume=0.25;
	Out.ar(0,
		PlayBuf.ar(2, ~guitar.bufnum, BufRateScale.kr(~guitar.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\marimba, { arg loop=0, volume=0.3;
	Out.ar(0,
		PlayBuf.ar(2, ~marimba.bufnum, BufRateScale.kr(~marimba.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\bass3, { arg loop=0, volume=0.3;
	Out.ar(0,
		PlayBuf.ar(2, ~bass3.bufnum, BufRateScale.kr(~bass3.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\bv, { arg loop=0, volume=0.3;
	Out.ar(0,
		PlayBuf.ar(2, ~bv.bufnum, BufRateScale.kr(~bv.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\vox, { arg loop=0, volume=0.3;
	Out.ar(0,
		PlayBuf.ar(2, ~vox.bufnum, BufRateScale.kr(~vox.bufnum), loop:loop, doneAction:2)*volume
)}).add;
)
};

~mySamples.value;
)

(
// when evaluating above expressions
// probably need to wait half a second for samples to load from disk before evaluating
// nectlot of expressions
~sampleDurations = [~drums.duration, ~bass.duration, ~guitar.duration,  ~bv.duration,  ~marimba.duration,  ~vox.duration];
// this current hack is used to get info on sample duration

~globalTempo = 122/60;  // in case one of the choosers has no clock chooser
~globalBeatsPerBar = 4;

"=========".postln;
"=========".postln;
 "=========".postln;
)

// Audition the samples individually
Synth(\drums);
Synth(\bass);
Synth(\guitar);
Synth(\bv);
Synth(\marimba);
Synth(\vox);


// A single soundable chooser
Maker.new.scenario1.make.play;


// A sequence of soundable choosers
(
~train= Train.new1.addAll(   // this lets you have sequences of choosers of any length
	[
	  Maker.new.init.make,
	  Maker.new.init2.make,
	  Maker.new.init3.make,
     ]);
)


"about to play".postln;
~train.play




(
~train= Train.new1.addAll(   // this lets you have sequences of choosers of any length
	[
	  Maker.new.init.make,
	  Maker.new.init2.make,
	  Maker.new.init.make,
	  Maker.new.init3.make,
	  Maker.new.init2.make,
	  Maker.new.init.make,

     ]);
)



~ch = PlayableChooser.new;

"=========".postln;
"=========".postln;
 "=========".postln;
~ch.init.play;


"=========".postln;
"=========".postln;
 "=========".postln;
~ch.proto3

"=========".postln;
"=========".postln;
 "=========".postln;
~ch.proto2


"=========".postln;
"=========".postln;
 "=========".postln;
~ch.proto1


"=========".postln;
 "=========".postln;
~ch.demo2;

"=========".postln;
 "=========".postln;
~ch.demo3;

"=========".postln;
 "=========".postln;
~ch.demo4;

"=========".postln;
 "=========".postln;
~ch.demo5.inspect

"=========".postln;
 "=========".postln;
~ch.demo1;

"=========".postln;
 "=========".postln;
~ch.demo6;


"=========".postln;
 "=========".postln;
~ch.demo8






		