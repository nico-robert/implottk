# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::implottk {

    oo::class create imgui {
        variable _cmdimgui
            
        method addImGUICmds {args} {
            lappend _cmdimgui [lindex $args 0]
        }
        
    }
}