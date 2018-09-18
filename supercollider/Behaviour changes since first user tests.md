# Always play is replaced by infinity
Infinity weight - if the nose cone value allows, prioritise infinity weight lanes before moving to an auction for any other selectable lanes (weight ≥ 1). If the nose cone value is less than the number of infinity-weighted lanes, run a straight auction between them.

# Infinity nose cone - play all available soundable lanes
Play all soundable lanes with a positive integer weight. Any lane with a weight of zero is not available and cannot be played.

# Infinity duration - play infinitely
Note: This will be different to the behaviour without a time chooser. A soundable chooser without a time chooser will play until the soundable content has finished (unless one or more lanes is set to infinite repeats). A time chooser with a duration of ∞, and a soundable chooser with durations lower than ∞, will play the content and then play infinite silence.

# Soundable Chooser lanes have a set number of repeats, including infinity repeats
* This replaces the previous loop/non-loop setting.
* A set number of repeats can be specified.
* Infinity repeats == loop
* Zero repeats == same behaviour as zero weight. The lane is not available for selection.

# Hard and soft stops now per lane, not global across the entire chooser
Each lane has its own stop behaviour

# Time chooser lanes containing a sample have a set number of repeats and can be made audible
Each Time Chooser lane containing a sample has a set number of repeats (as Soundable Chooser lanes)
