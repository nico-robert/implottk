# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

# Release:
# 15-09-2022 : 1.0b0
# 19-09-2022 : 1.0b1
# - Add _SubplotsSizing_ + _SubplotItemSharing_ (drag & drop) demo.
# - Cosmetic changes + adding `imgui` functions.
# 01-10-2022 : 1.0b2
# - Add examples.
# - Fix bug when my frame was mapped or unmapped.
# - Rename win32.tcl file by user32.tcl

package require Tcl 8.6
package require Tk
package require cffi 1.1

cffi::alias load C
cffi::alias load win32

set dir [file dirname [file normalize [info script]]]

# imgui
source [file join $dir imgui_enums.tcl]
source [file join $dir imgui_alias.tcl]
source [file join $dir imgui_structs.tcl]
source [file join $dir imgui_funcs.tcl]

# implot
source [file join $dir implot_enums.tcl]
source [file join $dir implot_alias.tcl]
source [file join $dir implot_structs.tcl]
source [file join $dir implot_funcs.tcl]

# user32
source [file join $dir user32.tcl]

# wingdi
source [file join $dir wingdi.tcl]

# opengl
source [file join $dir gl.tcl]

# glfw3 (work in progress...)
# source [file join $dir glfw3.tcl]

# directX (work in progress...)
# source [file join $dir dxgi.tcl]
# source [file join $dir d3d11.tcl]

source [file join $dir implottk_imgui.tcl]
source [file join $dir implottk_lineseries.tcl]
source [file join $dir implottk_frame.tcl]
source [file join $dir implottk_data.tcl]
source [file join $dir implottk_utils.tcl]

namespace eval ::implottk {
    variable version 1.0b2
    variable dir $dir
}

if {$::tcl_platform(machine) eq "amd64"} {
    cffi::Wrapper create CIMGUI [file join $implottk::dir lib amd64 cimgui_x64.dll]
} else {
    cffi::Wrapper create CIMGUI [file join $implottk::dir lib x86 cimgui_x86.dll]
}

# init imgui + plot
imgui::init
imgui::initprocFunc

implot::init
implot::initprocFunc

if {[imgui::GetVersion] != 1.88} {
    set msg "Warning : 'Dear Imgui' version (1.88) is only supported..."
    puts stderr $msg
    tk_messageBox -icon warning -message $msg -title "Message..."
}

package provide implottk $implottk::version