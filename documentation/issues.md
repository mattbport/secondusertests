# Issue list

- [ ] Soundable content needed in Time Choosers
- [ ] Error when using multiple infinite-weighted lanes in Soundable Choosers. One infinite weight is fine - two or more throws an error
- [ ] Multiple `ERROR: Message 'isSymbol' not understood` errors, but does not seem to be a showstopper

-------------

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

- Loops do not work - if a lane is shorter than the Time Chooser's duration, and the lane is set to loop, it does not look and there is a gap before the duration completes and the next Chooser starts.

--------

## Run through questions
### S1
S1 all fine

### S2
S2 all fine

### S3
S3 understanding fine

S3 implementation:

```
// S3 implementation question
(
~ch1 = Xhooser.new;
~ch1.noseCone_(3);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\drums).loopOn);
~ch1.addLane( Lane.new.weight_(inf).namedSample(\bass).loopOn);
~ch1.addLane( Lane.new.weight_(1).namedSample(\guitar).loopOn);
~ch1.addLane( Lane.new.weight_(2).namedSample(\marimba).loopOn);
 )

~ch1.play;
```

**ISSUE** - Does not work correctly. Post window shows `playable not found` and repeated runs of the `play` message throws new errors. Seems to be due to the use of two infinitely weighted lanes.

NEW ISSUE 1st Dec - fails with the following message:

```
ERROR: Message 'duration' not understood.
RECEIVER:
Instance of String {    (0x10faf18c0, gc=01, fmt=07, flg=11, set=02)
  indexed slots [18]
      0 : p
      1 : l
      2 : a
      3 : y
      4 : a
      5 : b
      6 : l
      7 : e
      8 :  
      9 : n
     10 : o
     11 : t
     12 :  
     13 : f
     14 : o
     15 : u
     16 : n
     17 : d
```


### S4
Understanding Q - all fine

Implementing Q has problems:

**ISSUE** - same as in S3. There is an issue when there are 2 or more infinitely weighted lanes

NEW ISSUE 1st December - now does not run, with the following error:

```
ERROR: Message 'hardDuration' not understood.
RECEIVER:
Instance of String {    (0x10faf18c0, gc=01, fmt=07, flg=11, set=02)
  indexed slots [18]
      0 : p
      1 : l
      2 : a
      3 : y
      4 : a
      5 : b
      6 : l
      7 : e
      8 :  
      9 : n
     10 : o
     11 : t
     12 :  
     13 : f
     14 : o
     15 : u
     16 : n
     17 : d
}
```



### S5
Understanding Q - all fine, apart from the lack of soundable content in a time lane. How to add audio file to time lane?

**Update 1st Dec**: from Simon's new classes - marimba has been added, but when it is successfully picked we get the following error:

```
ERROR: Message 'duration' not understood.
RECEIVER:
Instance of String {    (0x10faf18c0, gc=01, fmt=07, flg=11, set=02)
  indexed slots [18]
      0 : p
      1 : l
      2 : a
      3 : y
      4 : a
      5 : b
      6 : l
      7 : e
      8 :  
      9 : n
     10 : o
     11 : t
     12 :  
     13 : f
     14 : o
     15 : u
     16 : n
     17 : d
}
```

**ISSUE** with the sequence - the duration of the chooser is not being reported correctly, leading to overlapping sequences.

```
/────┬──────────────────┬───┬───┬───┐
│    │    drums.wav     │ ∞ │x∞ │ h │
│    ├──────────────────┼───┼───┼───┤
│    │     bass.wav     │ 2 │x2 │ h │
│ ∞  ├──────────────────┼───┼───┼───┤
│    │    guitar.wav    │ 1 │x1 │ h │
│    ├──────────────────┼───┼───┼───┤
│    │     vox.wav      │ ∞ │x∞ │ s │
├────┼──────────────────┴───┴───┼───┤
│    │          4 bars          │ 2 │
│    ├──────────────────────────┼───┤
│ 1  │          6 bars          │ 1 │
│    ├──────────────────────────┼───┤
│    │          8 bars          │ 2 │
\────┴──────────────────────────┴───┘
```


### S6

Should be OK if steering around known issues:

- Multiple infinity weights in soundables;
- No soundable content in time lanes.