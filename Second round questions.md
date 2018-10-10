### Content and logical flow

```
             ┌────────────────────┐                                                  
             │       Lanes        │                                                  
             │                    │                                                  
             └────────────────────┘                                                  
                        │                                                            
                        ▼                                                            
             ┌────────────────────┐                                                  
             │      Repeats       │                                                  
             │                    │                                                  
             └────────────────────┘                                                  
                        │                                                            
                        ▼───────────────────────────┐                                
             ┌────────────────────┐                 ▼                                
             │      Sequence      │      ┌────────────────────┐                      
             │                    │      │     ∞ repeats      │                      
             └────────────────────┘      │                    │                      
                        │                └────────────────────┘                      
                        ▼                                                            
             ┌────────────────────┐                                                  
             │ Soundable Chooser  │                                                  
             │                    │                                                  
             └────────────────────┘                                                  
                        │                                                            
                        ▼                                                            
             ┌────────────────────┐                                                  
             │  Basic nose cone   │                                                  
             │   functionality    │                                                  
             └────────────────────┘                                                  
                        │                                                            
                        ▼───────────────────────────┐                                
             ┌────────────────────┐                 ▼                                
             │    Basic weight    │      ┌────────────────────┐                      
             │                    │      │    ∞ nose cone     │                      
             └────────────────────┘      │                    │                      
                        │                └────────────────────┘                      
                        ▼───────────────────────────┐                                
             ┌────────────────────┐                 │                                
             │ Basic Time Chooser │                 ▼                                
             │                    │      ┌────────────────────┐                      
             └────────────────────┘      │   ∞ lane weight    │                      
                        │                │                    │                      
                        │                └────────────────────┘                      
           ┌────────────┤                           │                                
           │            │                           ▼                                
           ▼            │                ┌────────────────────┐                      
┌────────────────────┐  │                │  Priority seating  │                      
│  Time Chooser as   │  │                │      metaphor      │                      
│  duration control  │  │                └────────────────────┘                      
└────────────────────┘  └─────────────────────────────────────────────────┐          
           │                                                              │          
           │                                                              │          
           ▼───────────────────────────────────┐                          │          
┌────────────────────┐                         │                          │          
│ Hard and soft stop │                         │                          │          
│                    │                         ▼                          │          
└────────────────────┘              ┌────────────────────┐                │          
           │                        │     ∞ duration     │                │          
           ▼                        │                    │                ▼          
┌────────────────────┐              └────────────────────┘     ┌────────────────────┐
│Soundable time lane │                                         │  Nondeterministic  │
│    with on/off     │                                         │    Time Chooser    │
└────────────────────┘                                         └────────────────────┘
```


### Proposed order
```
           ┌────────────────────┐                              
           │       Lanes        │                              
           │                    │                              
           └────────────────────┘                              
                      │                                        
                      ▼                                        
           ┌────────────────────┐                              
           │      Repeats       │                              
           │                    │                              
           └────────────────────┘                              
                      │                                        
                      ├──────────────┐                         
           ┌──────────┘              ▼                         
           │              ┌────────────────────┐               
           ▼              │      Sequence      │               
┌────────────────────┐    │                    │               
│     ∞ repeats      │    └────────────────────┘               
│                    │               │                         
└────────────────────┘               ▼                         
                          ┌────────────────────┐               
                          │ Soundable Chooser  │               
                          │                    │               
                          └────────────────────┘               
                                     │                         
                                     ▼                         
                          ┌────────────────────┐               
                          │  Basic nose cone   │               
                          │   functionality    │               
                          └────────────────────┘               
                                     │                         
                                     ▼                         
                          ┌──────────┴─────────┐               
                          │    Basic weight    │               
                          │                    │               
                          └──────────┬─────────┘               
                                     │                         
                                     ├──────────────┐          
                                     │              ▼          
                                     │   ┌────────────────────┐
                                     │   │   ∞ lane weight    │
                                     │   │                    │
                            ┌────────┤   └────────────────────┘
                            │        │              │          
                            │        │              ▼          
                            │        │   ┌────────────────────┐
                            │        │   │  Priority seating  │
                            │        │   │      metaphor      │
                            ▼        │   └────────────────────┘
                 ┌───────────────────┼┐                        
                 │Basic Time Chooser,││                        
                 │    Full Chooser   ││                        
                 └───────────────────┼┘                        
              ┌─────────────┐        │                         
              │             ▼        │                         
              │  ┌───────────────────┼┐                        
              │  │  Time Chooser as  ││                        
              │  │  duration control ││                        
              │  └───────────────────┼┘                        
              │             ┌────────┼──────────────┐          
              │             ▼        │              ▼          
              │  ┌───────────────────┼┐  ┌────────────────────┐
              │  │ Hard and soft stop││  │     ∞ duration     │
              │  │                   ││  │                    │
              │  └───────────────────┼┘  └────────────────────┘
              │             ─────────┼───────────┐             
              ▼                      │           │             
   ┌────────────────────┐            │           │             
   │  Nondeterministic  │            │           │             
   │    Time Chooser    │            │           │             
   └────────────────────┘            ▼           │             
                          ┌────────────────────┐ │             
                          │    ∞ nose cone     │ │             
                          │                    │ │             
                          └────────────────────┘ │             
                                                 ▼             
                                      ┌────────────────────┐   
                                      │Soundable time lane │   
                                      │    with on/off     │   
                                      └────────────────────┘   
```

![](images/2nd-round-content.png)

## Simple structure
* Lanes
* Repeats
* Sequence

## Soundable Chooser basics
* Soundable Chooser
* Nose cone
* Weight

## Infinity weight
* ∞ weight
* Priority seating

## Full Chooser basics
* Full Chooser, introducing the...
* Time Chooser
* Nose cone limitations for the Time Chooser
* Hard and soft stops

## Advanced features
* Nondeterministic Time Chooser
* ∞ nose cone
* ∞ duration
* ∞ repeats
* Soundable content in a Time Chooser lane


# Second round user test questions

Questionnaire for participants: <https://goo.gl/forms/YHTjQz8HcXG0AEO52> 


## S1: Basics

### Understanding

*Video introducing samples, lanes, repeats, and sequence*

```
┌──────────────────┬────┐      ┌──────────────────┬────┐
│     amen.wav     │ x2 │─────▶│     bass.wav     │ x1 │
└──────────────────┴────┘      └──────────────────┴────┘
```

* Explain what will happen when this sequence is run
* How many times will the `bass.wav` sample play?
* How could you change the order of the sequence?
* How could you change the `amen.wav` sample from 2 to 4 repetitions?

### Implementing

* How could you add a third sample to be played after the `bass.wav` sample has finished playing?


## S2: Soundable Chooser basics

### Understanding
*Video introducing Soundable Choosers, including the nose cone and the weight column*

Here is a **Soundable Chooser** with two samples.

```
/────┬──────────────────┬───┬───┐
│    │    drums.wav     │x1 │ 1 │
│ 1  ├──────────────────┼───┼───┤
│    │     bass.wav     │x1 │ 1 │
└────┴──────────────────┴───┴───┘
```

* If this Chooser is played by itself, how many samples will play? 
* How do you know? 
* How likely is it that the `drums.wav` sample will play? How could you make it more likely to play? 
* How could you make the Chooser play both samples? 
* How would you make it play no samples?


### Implementing

Using the whiteboard, draw a Soundable Chooser with the following characteristics:

* Three lanes, containing `drums.wav`, `bass.wav`, and `guitar.wav`
* Set all lanes to play the samples 4 times each
* Make it so two of the three samples will play simultaneously
* Make it so that the drums are twice as likely to play as the other samples



## S3: Infinity weight
*Video introducing infinity weight and the priority seating and lottery analogy, with visual aids*

### Understanding

```
/────┬──────────────────┬───┬───┐
│    │    drums.wav     │x4 │ ∞ │
│    ├──────────────────┼───┼───┤
│ 2  │     bass.wav     │x4 │ 2 │
│    ├──────────────────┼───┼───┤
│    │    guitar.wav    │x4 │ 1 │
└────┴──────────────────┴───┴───┘
```

* What will happen when this Soundable Chooser runs?
	* [discussion to test understanding]
		* Two lanes will be selected
		* Infinity weighted lane gets 'priority seating'
		* There is a lottery for the remaining 'seat'. `bass.wav` is more likely to be selected


### Implementation

Using the whiteboard, draw a Soundable Chooser for the following scenario:

* Four lanes: `drums.wav`, `bass.wav`, `guitar.wav`, and `marimba.wav`
* Both `drums.wav` and `bass.wav` should always be selected to play
* Either `guitar.wav` or `marimba.wav` should play. `marimba.wav` is twice as likely as `guitar.wav` to be selected


## S4: Full Chooser basics
### Understanding

*Video introducing a Time Chooser to a Soundable Chooser, making a Full Chooser; the nose cone limitations for a Time Chooser; infinity repeats; and hard and soft stops (with visuals).*

```
/────┬──────────────────┬───┬───┬───┐
│    │    drums.wav     │ ∞ │ ∞ │ s │
│ 2  ├──────────────────┼───┼───┼───┤
│    │     bass.wav     │ ∞ │ 2 │ h │
├────┼──────────────────┼───┴───┴───┘
│ 1  │      4 bars      │            
\────┴──────────────────┘            
```

* Describe what will happen when this Full Chooser is run.
* What will happen when the Time Chooser's duration has elapsed? 
* The Time Chooser's nose cone is currently set to 1. What else could it be set to? What would happen if it is changed?


### Implementation

Create a Full Chooser with these characteristics:

- Six soundable lanes - these should contain `drums.wav`, `bass.wav`, `guitar.wav`, `marimba.wav`, `bvs.wav`, and `vox.wav`
- Four of the six samples will play simultaneously
- `vox.wav` and `marimba.wav` will always play. Of the remaining lanes, `drums.wav` should be more likely than the others to play
- All soundable lanes should play infinitely until they are stopped by the Time Chooser
- `vox.wav` and `bvs.wav` should be set to a soft stop. All other lanes should be set to a hard stop.
- The Time Chooser should be set to a duration of 8 bars


## S5: Advanced features
### Understanding
*Video introducing ∞ for the Soundable nose cone, and ∞ as a duration in a Time Chooser; multiple lanes in a Time Chooser, including weighted choice and nose cone limitations; soundable content in a Time Chooser, including mute/non-mute.*

```
/────┬──────────────────┬───┬───┬───┐
│    │    drums.wav     │x∞ │ ∞ │ h │
│    ├──────────────────┼───┼───┼───┤
│    │     bass.wav     │x2 │ 2 │ h │
│ ∞  ├──────────────────┼───┼───┼───┤
│    │    guitar.wav    │x1 │ 1 │ h │
│    ├──────────────────┼───┼───┼───┤
│    │     vox.wav      │x∞ │ ∞ │ s │
├────┼──────────────────┼───┼───┼───┘
│    │      4 bars      │   │ 2 │    
│    ├──────────────────┤   ├───┤    
│ 1  │      6 bars      │   │ 1 │    
│    ├──────────────────┤   ├───┤    
│    │      8 bars      │   │ 2 │    
\────┴──────────────────┘   └───┘    
```

* Explain what will happen in the Time Chooser
* What effect will this duration have on the Soundable Chooser lanes?
* In the Soundable Chooser, which lanes will be selected, and which may be selected? What is the likelihood of selection?
* In the Soundable Chooser, what effect will the repeat settings have?
* What effect will the Soundable nose cone setting have?

### Implementation

Sketch out the previous example on the whiteboard, and make the following changes:

* Make the Full Chooser play infinitely
* Make it so 2 lanes are chosen, and make all lanes equally likely to be selected
* Next, make it so the Full Chooser has a duration of either 4 or 8 bars, with hard stops on all lanes
* Next, create a sequence with the Full Chooser playing 4 times in a row

## S6: Playground

Using the whiteboard and the available samples, make a piece of music which uses a sequence of three Choosers. The music will be recorded and shared online.

The piece should be musically satisfying even if it is run only once. If it is run more than once it should be different in some way.


----

### Notes
* Introduction; what we are doing
* Questionnaire
* Information we are going to gather and agree as co-participants:
	* Questions (why does the loop do that?)
	* Problems (I don’t understand what these lanes are for)
	* Suggestions (maybe the cone should be a different shape)
	* Other observations (I like the fins)


Run through the tests. Are there any other ways to do that? Can you think of any other ways that could be done?

* Can you see anything this would be useful for?
* Can you see any ways in which this is similar to other tools you have used?
* Is there anything that is made easier by this system? Anything which was not possible made possible/hard and made easier?