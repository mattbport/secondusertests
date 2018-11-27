//VERSION z-test-9.scd
// Note that my version has to use different file paths
// and (for convenience only) I am using  ~mySamples,  which is of course not essential
// however  use of ~sampleDurations  = [~drums.duration, ~bass.duration, ~guitar.duration,
//                      ~bv.duration,  ~marimba.duration,  ~vox.duration]
// is currently essential, though we need a better way to get duration of samples

(
~mySamples= {
(
~zero = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/0.wav");
~one = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/1.wav");
~two = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/2.wav");
~three = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/3.wav");
~four = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/4.wav");
~five = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/5.wav");
~six = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/6.wav");
~seven = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/7.wav");
~eight = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/8.wav");
~nine = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/9.wav");
~ten = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/10.wav");
~eleven = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/11.wav");
~twelve = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/12.wav");
~thirteen= Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/13.wav");
~fourteen = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/14.wav");
~fifteen = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/15.wav");
~sixteen = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/16.wav");
~seventeen = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/17.wav");
~eighteen = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/18.wav");
~nineteen = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/19.wav");
~twenty = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/20.wav");
~twentyone = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/21.wav");
~twentytwo = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/22.wav");
~twentythree = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/23.wav");
~twentyfour = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/24.wav");
~twentyfive = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/25.wav");
~twentysix = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/26.wav");
~twentyseven = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/27.wav");
~twentyeight = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/28.wav");
~twentynine = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/29.wav");
~thirty= Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/30.wav");
~thirtyone= Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/31.wav");
~thirtytwo = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/32.wav");
~thirtythree = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/33.wav");
~thirtyfour = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "../csamples/34.wav");



SynthDef(\0, { arg loop=0, volume=1;
	Out.ar(0,
		PlayBuf.ar(2, ~zero.bufnum, BufRateScale.kr(~zero.bufnum), loop:loop, doneAction:2)*volume
)}).add;

		SynthDef(\1, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~one.bufnum, BufRateScale.kr(~one.bufnum), loop:loop, doneAction:2)*volume
)}).add;

		SynthDef(\2, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~two.bufnum, BufRateScale.kr(~two.bufnum), loop:loop, doneAction:2)*volume
)}).add;

		SynthDef(\3, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~three.bufnum, BufRateScale.kr(~three.bufnum), loop:loop, doneAction:2)*volume
)}).add;

		SynthDef(\4, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~four.bufnum, BufRateScale.kr(~four.bufnum), loop:loop, doneAction:2)*volume
)}).add;

		SynthDef(\5, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~five.bufnum, BufRateScale.kr(~five.bufnum), loop:loop, doneAction:2)*volume
)}).add;

		SynthDef(\6, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~six.bufnum, BufRateScale.kr(~six.bufnum), loop:loop, doneAction:2)*volume
)}).add;

		SynthDef(\7, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~seven.bufnum, BufRateScale.kr(~seven.bufnum), loop:loop, doneAction:2)*volume
)}).add;

				SynthDef(\8, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~eight.bufnum, BufRateScale.kr(~eight.bufnum), loop:loop, doneAction:2)*volume
)}).add;

				SynthDef(\9, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~nine.bufnum, BufRateScale.kr(~nine.bufnum), loop:loop, doneAction:2)*volume
)}).add;

				SynthDef(\10, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~ten.bufnum, BufRateScale.kr(~ten.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\11, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~eleven.bufnum, BufRateScale.kr(~eleven.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\12, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twelve.bufnum, BufRateScale.kr(~twelve.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\13, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~thirteen.bufnum, BufRateScale.kr(~thirteen.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\14, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~fourteen.bufnum, BufRateScale.kr(~fourteen.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\15, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~fifteen.bufnum, BufRateScale.kr(~fifteen.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\16, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~sixteen.bufnum, BufRateScale.kr(~sixteen.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\17, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~seventeen.bufnum, BufRateScale.kr(~seventeen.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\18, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~eighteen.bufnum, BufRateScale.kr(~eighteen.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\19, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~nineteen.bufnum, BufRateScale.kr(~nineteen.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\20, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twenty.bufnum, BufRateScale.kr(~twenty.bufnum), loop:loop, doneAction:2)*volume
)}).add;

						SynthDef(\21, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentyone.bufnum, BufRateScale.kr(~twentyone.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\22, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentytwo.bufnum, BufRateScale.kr(~twentytwo.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\23, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentythree.bufnum, BufRateScale.kr(~twentythree.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\24, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentyfour.bufnum, BufRateScale.kr(~twentyfour.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\25, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentyfive.bufnum, BufRateScale.kr(~twentyfive.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\26, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentysix.bufnum, BufRateScale.kr(~twentysix.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\27, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentyseven.bufnum, BufRateScale.kr(~twentyseven.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\28, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentyeight.bufnum, BufRateScale.kr(~twentyeight.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\29, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~twentynine.bufnum, BufRateScale.kr(~twentynine.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\30, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~thirty.bufnum, BufRateScale.kr(~thirty.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\31, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~thirtyone.bufnum, BufRateScale.kr(~thirtyone.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\32, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~thirtytwo.bufnum, BufRateScale.kr(~thirtytwo.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\33, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~thirtythree.bufnum, BufRateScale.kr(~thirtythree.bufnum), loop:loop, doneAction:2)*volume
)}).add;

								SynthDef(\34, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~thirtyfour.bufnum, BufRateScale.kr(~thirtyfour.bufnum), loop:loop, doneAction:2)*volume
)}).add;





	)

};

~mySamples.value;
)

(
// when evaluating above expressions
// probably need to wait half a second for samples to load from disk before evaluating
// nectlot of expressions
~sampleDurations = [~zero.duration, ~one.duration, ~two.duration,  ~three.duration,  ~four.duration,  ~five.duration, ~six.duration, ~seven.duration];
// this current hack is used to get info on sample duration

~globalTempo = 120/60;  // in case one of the choosers has no clock chooser
~globalBeatsPerBar = 4;

"=========".postln;
"=========".postln;
 "=========".postln;
)


// Audition the samples individually
Synth(\0);
Synth(\1);
Synth(\2);
Synth(\26);


// A single soundable chooser
Maker.new.init2.make.play;

// hard stop


// A sequence of soundable choosers
(
~train= Train.new1.addAll(   // this lets you have sequences of choosers of any length
	[
	  Maker.new.init.make,
	  Maker.new.init2.make,
	  Maker.new.init.make,
		// Maker.new.init3.make,
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






		