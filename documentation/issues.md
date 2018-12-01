# Issue list

## test.Xhooser4.scd

`Lane` not working? Error thrown when creating a new lane: `~laneA = Lane.new;`

`ERROR: Message 'isSymbol' not understood.`

-------

When running 

```
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
```

... we have an error on the shortPlay message line:

`ERROR: Message 'shortPlay' not understood.`

Plus, the same `ERROR: Message 'isSymbol' not understood.` message.

--------

## timeChooser example.scd

Allows for the creation of Choosers, and everything seems very clear and sensible (creation and then population of Soundable and Time Choosers).

### Playback of a single Chooser
Multiple instances of the error `ERROR: Message 'isSymbol' not understood.` - this happens on playback of a single Chooser. It is not a showstopper as the Chooser still plays. Presumably we are sending the wrong type of message to something in a class?


### Sequencing Choosers
There seems to be a playback issue when sequencing Choosers. Specifically, timing does not appear to be accurate.

**Need tests to find what is wrong**