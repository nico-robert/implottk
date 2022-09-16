# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::implottk {

    oo::class create lineSeries {
        variable _series  ; # list num series
        variable _cmdplot ; # list commands plot
    
        method series {num args} {
            # Configure line serie
            #
            # num  - num serie
            # args - options described below.
            #
            # -data      - list x y data (not supported yet).
            # -dataX     - list values x.
            # -dataY     - list values y.
            # -name      - name serie.
            # -lineStyle - options described below.
            #       color  - list 3 RGB values for line style
            #       weight - size point line
            #
            # Returns nothing
            foreach {key value} $args {
                if {$value eq ""} {
                    error "No value specified for key '$key'"
                }
                
                switch -exact -- $key {
                    -data       {dict set dataseries -data  $value}
                    -dataX      {dict set dataseries -dataX $value}
                    -dataY      {dict set dataseries -dataY $value}
                    -name       {dict set dataseries -name  $value}
                    -lineStyle  {
                    
                        set colorline  ""
                        set weightline ""

                        foreach {keystyle valuestyle} $value {
                            if {$valuestyle eq ""} {
                                error "No value specified for subkey '$keystyle'"
                            }
                            
                            switch -exact -- $keystyle {
                                color {
                                    if {[llength $valuestyle] != 3} {
                                        error "list color should be equal to 3..."
                                    }
                                    set colorline [implottk::rgbaToVec4 $valuestyle]
                                }
                                
                                weight {
                                    if {![string is integer $valuestyle] || $valuestyle <= 0} {
                                        error "Size font should be greater than 0"
                                    }
                                    set weightline $valuestyle
                                }
                                
                                default {error "Unknown key '$keystyle' specified"}
                            }
                        }
                        
                        
                        if {$colorline ne "" && $weightline ne ""} {
                            lappend _cmdplot [list implot::SetNextLineStyle $colorline $weightline]
                        }
                        
                        if {$colorline ne "" && $weightline eq ""} {
                            lappend _cmdplot [list implot::SetNextLineStyle $colorline]
                        }
                        
                        if {$colorline eq "" && $weightline ne ""} {
                            lappend _cmdplot [list implot::SetNextLineStyle [implottk::rgbaToVec4 {0 0 0 -255}] $weightline]
                        }

                    }
                    default {error "Unknown key '$key' specified"}
                }
            }
            
            if {$num in $_series} {
                error "This series is already configured..."
            }
                        
            lappend _cmdplot [implottk::dataLine $num $dataseries]
            lappend _series $num

            return {}

        }
        
        method addLinePlotCmds {args} {
            # Add command on the fly
            #
            # args - command line plot
            #
            # Returns nothing
            lappend _cmdplot [lindex $args 0]
            
            return {}
        }
    }
}