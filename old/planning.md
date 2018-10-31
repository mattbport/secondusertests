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
