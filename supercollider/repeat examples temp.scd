SHORTENING AND REPEATING SAMPLES


// JUST DO ONCE - CREATE SAMPLE BANK
     SampleBank.populate;
// Wait for it.....
      SampleBank.warmUp;   // add traces to show what sc classes involved

SampleBank.at(\bass).play   // 2 goes of riff
SampleBank.at(\bass).shortPlay(2)

(TimeLane.new.beats(2)).inspect;

Lane.new.weight_(3).namedSample(\bass)        .loopOn
Lane.new.weight_(3).namedSample(\bass).loopOn


10% 3
7 % 6
10/3

