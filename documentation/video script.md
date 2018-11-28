# S1: Basics

*Video introducing samples, lanes, and sequence*

The largest central area of the user interface is known as the play area. It is here that the user is able to assemble, audition, and package musical structures.

We can drag samples into the play area. The samples are shown in lanes. Anything in a lane can be auditioned by clicking on it.

A sequence is shown by arrows connecting lanes or choosers. The direction of the arrow indicates the order of the sequence. Only a single arrow can enter or exit each element in a sequence.

Here we have a simple example showing a sequence of samples. Once the first sample has finished playing the second sample will begin. 



# S2: Soundable Chooser basics

*Video introducing Soundable Choosers, including the nose cone, loop/non-loop, and the weight column*

If two or more lanes containing samples are snapped together vertically they become a soundable chooser. 

If there are two or more lanes in a chooser, the lane will display a nose cone on the right, and additional controls on the left of each lane.

The nose cone allows the user to specify how many of the lanes will be played simultaneously. For example, if there are three lanes, and the nose cone contains the number two, two lanes will be chosen to play simultaneously. If the nose cone contains the number one, only a single lane will be chosen. Note that every time the chooser is played, the choice of lanes is made afresh non-deterministically (that is, at random).

The first control on the right controls loop behaviour. For now we will use this control to either loop the lane, or to play once without looping.

The weight control, shown on the far right, determines the relative likelihood of a lane to be selected for playback. Here we have three lanes each with a weight of one, meaning they are equally likely to be selected. If one lanes weight was changed to two it would now be more likely to be selected for playback. If a lane is given a weight of zero it will never be selected for playback. This can be a useful way of trying arrangement ideas without removing the lane altogether. 


# S3: Infinity weight

*Video introducing infinity weight and the priority seating and lottery analogy, with visual aids*

Let's say you have a lane which needs to always be selected; for example, you may need a vocal line to always play. To do this you can give the lane a weight of infinity, which means that the lane will be selected before any non-infinitely weighted lanes.

In order to understand infinity weight, it can be useful to think of an aeroplane with a limited number of seats. Lanes with infinite weight are the priority boarding passengers, and they are given the first seats on the plane. If there are still seats left after the priority boarders have taken their seats, there is a lottery held among the remaining passengers. If there are too few seats to accommodate the priority boarders, as shown here, then there is a straight lottery to fill the available seats.

Here's an example. Imagine we have a plane with four seats to fill, and six passengers waiting to board. There are obviously more passengers than seats, so we need a system. Each passenger has a weight. Passenger 1 has a priority boarding pass - infinity weight - and so takes one of the seats. Passenger 4 also has infinity weight, and takes another seat. This leaves 2 seats, and 4 passengers. All four passengers had the opportunity to purchase lottery tickets for this eventuality. One passenger, passenger 5, does not have a ticket and therefore cannot travel. A lottery is held between the three valid passengers, and passenger 6 is the winner - she takes a seat on the plane. A second lottery is held, and passenger 2 is the winner - this is despite them having only 1 lottery ticket compared to passenger 3's 2 tickets. The final seat is thereby filled.



# S4: Full Chooser basics
*Video introducing a Time Chooser to a Soundable Chooser, making a Full Chooser; the nose cone limitations for a Time Chooser; and hard and soft stops (with visuals).*

A time lane is a lane whose purpose is to specify a musical duration, usually in beats or bars or seconds.

A time lane can be included in what is known as a time chooser, as seen here. Note that the time chooser has a nose cone which contrasts visually with the nosecone of a soundable chooser. Time choosers and soundable choosers have similarities and differences. 

A soundable chooser can be given a limited musical duration by adding a time chooser to its bottom, as seen here - note how the nose cones fit together. The duration of the soundable chooser will now be controlled by the time chooser. Together the two types of chooser are referred to as a full chooser, or just a chooser for short. The purpose of a time chooser within a full chooser is to moderate in a non-deterministic manner how long the soundable chooser and its individual lanes play.

When you add a Time Chooser to a Soundable Chooser you can control how each soundable lane will stop when the Time Choosers duration has elapsed. Most music software allows us to stop playback immediately - in Choosers, this is know as a hard stop. Choosers contain another type of stop, called a soft stop. When a lane is set to a soft stop it allows the currently playing sample to finish before stopping. For example, you may want a melody to complete before stopping.

Here we have a full chooser consisting of a soundable chooser containing three samples, and a time chooser with a duration of eight bars. The status column of the time chooser shows either a soft stop (shown as >) or a hard stop (shown as ). In this example, one of three samples will be selected for playback. All samples are set to loop, as shown by the circular arrow. When the duration shown in the time chooser (8 bars) has elapsed the currently-playing sample will receive a stop command.

If the currently playing lane is set to a hard stop, the sample selected by the soundable chooser will be stopped as soon as time's up. If, by contrast, it were set to a soft stop, the sample would not be stopped at this point  instead the loop controlling the sample would be turned off and the sample would play to its end. Consequently, if the sample was shorter than 8 bars duration, it would loop one or more times before playing to its end after the loop was switched off. If the sample were longer than 8 bars, the entire sample should play just once.


# S5: Advanced features

*Video introducing  for the Soundable nose cone, and  as a duration in a Time Chooser; multiple lanes in a Time Chooser, including weighted choice and nose cone limitations; soundable content in a Time Chooser, including mute/non-mute.*

Infinity can be used in the nose cone of a Soundable Chooser as a quick way of playing all available lanes. If any lane has a weight of zero it is not available, and therefore will not be played.

As in Soundable Choosers, Time Choosers can contain multiple lanes, each with a weight to control the likelihood of selection. One key difference is that the nose cone in a Time Chooser will only allow one selection, or zero. This is to prevent us from selecting multiple durations simultaneously - the most common setting for the Time Chooser nose cone is 1, meaning that it will select one duration.

If the Time Choosers nose cone is set to zero any connected Soundable Chooser will run as though there is no time chooser. This allows for quick arrangement changes, with the possibility of infinite playback if the soundable chooser lanes are set to loop. If the soundable chooser is not set to loop the sample(s) will play and the chooser will be released when they have finished playing, regardless of length.

You may want to use the duration of a sample to control the duration of a Chooser. To do this, put the sample into a lane of a Time Chooser. You will see that there are two parameters on the right of the lane -- the weight to control the likelihood of selection, and a mute/play control. The mute/play allows you to control whether you want to hear the sample if the lane is selected, or if you want to use it for duration only, without hearing it.