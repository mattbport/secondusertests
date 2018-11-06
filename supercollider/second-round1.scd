(
// Add samples
~drums = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/drums8.wav");
~bass = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/bass4.wav");
~bass2 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/bass8.wav");
~guitar = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/gtr8.wav");
~marimba = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/marimba4.wav");
~bass3 = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/synthbass4.wav");
~bv = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/bv8.wav");
~vox = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "audio/vox8.wav");

// make synthdefs to play the samples
// each has loop on/off and basic volume control
// loop is still useful for the boolean switch in basic mode
// number of repeats comes at a later stage, and not in the user tests

SynthDef(\drums, { arg loop=0, volume=0.4;
	Out.ar(0,
		PlayBuf.ar(2, ~drums.bufnum, BufRateScale.kr(~drums.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\bass, { arg loop=0, volume=0.5;
	Out.ar(0,
		PlayBuf.ar(2, ~bass.bufnum, BufRateScale.kr(~bass.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\guitar, { arg loop=0, volume=0.25;
	Out.ar(0,
		PlayBuf.ar(2, ~guitar.bufnum, BufRateScale.kr(~guitar.bufnum), loop:loop, doneAction:2)*volume
)}).add;

SynthDef(\bass2, { arg loop=0, volume=0.3;
	Out.ar(0,
		PlayBuf.ar(2, ~bass2.bufnum, BufRateScale.kr(~bass2.bufnum), loop:loop, doneAction:2)*volume
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


(
~chooser = {
// setting the clock to the bpm of the samples
	m = Main.elapsedTime;
	c = TempoClock(122/60); // these samples are at 122bpm
	c.schedAbs( 0,
	k = {arg ...args;

var infinityweighted, infinityweightindex, lanes, weights, loops, nosecone, toplay, selectlane, chosen, chosenlocation, weightindex, durationinbars, beatsperbar, softstop, timenosecone, timeweights, timeselectlane, timelanes, timechosen, timechosenlocation, winningduration;

			// playable chooser settings
			lanes = [1,2,3,4,5,6];
			weights = [1,1,1,2,3,1]; // 999 means ∞, priority boarding
			loops = [1,1,1,1,1,1]; // boolean
			softstop = [0,0,0,0,0,0]; // stops are per-lane
			nosecone = 2;

			// time chooser settings
			timelanes = [1,2,3,4];
			timenosecone = 2; // either zero or 1
			beatsperbar = [4,4,4,4];
			durationinbars = [2,4,8,6];
			timeweights = [1,1,1,1];

		// start with no selection
		toplay = nil;

		// check to see if the nosecone allows for playback
		if (nosecone > 0, {

			// check to see if the ∞ weight count is greater than the nosecone number
			// if it is, run a straight lottery for the seats that are available
			if (weights.occurrencesOf(999) > nosecone , {
					"Only ".post; nosecone.post; " seats and ".post;
					weights.occurrencesOf(999).post;
					" priority passengers.".postln;
					"Seats to be allocated via an equal lottery.".postln;
			},
			{});


	// ******* How to check the number of legal lanes?? ************

	// check to see if the nose cone > number of legal lanes
	// if so, change nose cone value to the number of lanes
	// the UI would prevent this

	if (lanes.count({arg item, i; item.isPositive}) < nosecone , {
	nosecone = lanes.count({arg item, i; item.isPositive});
	"Nose cone value too high. Nose cone now set to ".post;
	nosecone.postln;
},
{});



for (1, nosecone, {

		if (weights.includes(999), {
						// put all 999 weighted lanes in an array
						// run the lottery on the array until the nosecone is empty
						// or the infinity array is empty
						infinityweightindex = weights.indexOf(999);
						infinityweighted = lanes.add(infinityweightindex);
						selectlane = { infinityweighted.choose };
						chosen = selectlane.value;
						chosenlocation = infinityweighted.indexOf(chosen);
						toplay = toplay.add(chosen);
						lanes.remove(lanes[chosenlocation]);
						weights.remove(infinityweighted[chosenlocation]);

						// weightindex = weights.indexOf(999); // index of the 999 weight
						// chosen = lanes[weightindex]; // use the index to get the lane number of the 999 weight lane
						// toplay = toplay.add(chosen); // add the chosen value to the 'toplay' array
						// lanes.remove(lanes[weightindex]); // prevent reselection by removing chosen value from initial list
						// weights.remove(weights[weightindex]); // remove corresponding weights of the chosen value
		},
		{
			selectlane = { lanes.wchoose(weights.normalizeSum) }; // Select a lane
			chosen = selectlane.value; // add the selected value to the variable 'chosen'
			chosenlocation = lanes.indexOf(chosen); // get the location of the 'chosen' value
			toplay = toplay.add(chosen); // add the chosen value to the 'toplay' array
			lanes.remove(lanes[chosenlocation]); // prevent reselection by removing chosen value from initial list
			weights.remove(weights[chosenlocation]); // remove corresponding weights of the chosen value
	})
				}
);

							"Playing lanes: ".post; toplay.postln;

	if (toplay.includes(1), { ~x = Synth(\drums, [\loop, loops[0]]) }, {} );
	if (toplay.includes(2), { y = Synth(\bass, [\loop, loops[1]])}, {} );
	if (toplay.includes(3), { z = Synth(\guitar, [\loop, loops[2]]) }, {} );
		if (toplay.includes(4), { q = Synth(\bv, [\loop, loops[3]]) }, {} );
	if (toplay.includes(5), { r = Synth(\marimba, [\loop, loops[4]])}, {} );
	if (toplay.includes(6), { t = Synth(\vox, [\loop, loops[5]]) }, {} );

				~x.onFree({"Drums have finished".postln});
				// y.onFree({"Bass has finished".postln});
				// z.onFree({"Guitar has finished".postln});
				// q.onFree({"BVs have finished".postln});
				// r.onFree({"Marimba has finished".postln});
				// t.onFree({"Vox has finished".postln});

},
{"Chooser skipped due to zero in nose cone".postln};

);

			timeselectlane = { timelanes.wchoose(timeweights.normalizeSum) };
			timechosen = timeselectlane.value;
			timechosenlocation = timelanes.indexOf(timechosen);
			winningduration = durationinbars[timechosenlocation];

									if ( timenosecone < 1, {
			"No time master, infinite playback".postln;
		},
		{

				if ( softstop[timechosenlocation] < 1, {

					"Chooser will hard stop in ".post; winningduration.post; " bars".postln;
					c.schedAbs( winningduration*beatsperbar[timechosenlocation], {
				q.free; r.free; t.free;x.free; y.free; z.free;
		})},
		{
					"Chooser will soft stop after ".post; winningduration.post; " bars".postln;
					c.schedAbs( winningduration*beatsperbar[timechosenlocation], {
			q.set(\loop, 0); r.set(\loop, 0); t.set(\loop, 0); x.set(\loop, 0); y.set(\loop, 0); z.set(\loop, 0); "Loops turned off now".postln;
		})});
			})
	}
);
})

~chooser.play