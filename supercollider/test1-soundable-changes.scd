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

// chooser values from the UI

var infinityweightindex, infinityweighted, lanes, weights, loops, nosecone, toplay, selectlane, chosen, chosenlocation, weightindex, lane1, lane2, lane3;

lanes = [1,2,3,4,5,6];
weights = [1,1,1,1,0,2]; // 999 == infinity weight, priority boarding
loops = [1,1,1,1,1,1];
nosecone = 4;

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


	// Remove zero-weighted lanes from selection
	// Lanes and weights are removed from the arrays

	while ( { weights.includes(0) }, {
	if (weights.includes(0), {
		weightindex = weights.indexOf(0);
		lanes.remove(lanes[weightindex]);
		weights.remove(weights[weightindex]);
	})});


	"Lanes: ".post; lanes.postln;
	"Weights: ".post; weights.postln;


	// Not sure if this is needed? Just in case...
	chosen = nil;
	weightindex = nil;


	// check to see if the nose cone > number of legal lanes
	// if so, change nose cone value to the number of lanes
	// the UI would prevent users from setting the nose cone higher
	// than the number of legal lanes
	// This also allows for infinity nose cone -- 999 will run all legal lanes
	if (lanes.size < nosecone , {
		nosecone = lanes.size;
		"Nose cone value too high. Nose cone now set to ".post;
		nosecone.postln;
		},
		{ "No nose cone change required".postln;
	});



for (1, nosecone, {

		// lottery needed here

		if (weights.includes(999), {
		// put all 999 weighted lanes in an array
		// run the lottery on the array until the nosecone is empty
		// or the infinity array is empty

			// infinityweightindex = weights.indexOf(999);
			// infinityweighted = lanes.add(infinityweightindex);
			// selectlane = { infinityweighted.choose };
			// chosen = selectlane.value;
			// chosenlocation = infinityweighted.indexOf(chosen);
			// toplay = toplay.add(chosen);
			// lanes.remove(lanes[chosenlocation]);
			// weights.remove(infinityweighted[chosenlocation]);

		weightindex = weights.indexOf(999);
		selectlane = { lanes.wchoose(weights.normalizeSum) };
		chosen = lanes[weightindex];
		toplay = toplay.add(chosen);
		lanes.remove(lanes[weightindex]);
		weights.remove(weights[weightindex]);
		},
		{
			"Selected: ".post;
			selectlane = { lanes.wchoose(weights.normalizeSum.postln) };
			chosen = selectlane.value.postln;
			chosenlocation = lanes.indexOf(chosen);
			toplay = toplay.add(chosen);
			lanes.remove(lanes[chosenlocation]);
			weights.remove(weights[chosenlocation]);
	})});

	if (toplay.includes(1), { x = Synth(\drums, [\loop, loops[0]]) }, { "Drums not chosen".postln } );
	if (toplay.includes(2), { y = Synth(\bass, [\loop, loops[1]])}, { "Bass not chosen".postln } );
	if (toplay.includes(3), { z = Synth(\guitar, [\loop, loops[2]]) }, {"Guitar not chosen".postln} );
		if (toplay.includes(4), { q = Synth(\bv, [\loop, loops[3]]) }, { "BVs not chosen".postln } );
	if (toplay.includes(5), { r = Synth(\marimba, [\loop, loops[4]])}, { "Marimba not chosen".postln } );
	if (toplay.includes(6), { t = Synth(\vox, [\loop, loops[5]]) }, {"Vox not chosen".postln } );

},
{"Chooser skipped due to zero in nose cone".postln}
)
)

q.free; r.free; t.free; x.free; y.free; z.free; // hard stop for all lanes

q.set(\loop, 0); r.set(\loop, 0); t.set(\loop, 0); x.set(\loop, 0); y.set(\loop, 0); z.set(\loop, 0); // soft stop for all lanes

