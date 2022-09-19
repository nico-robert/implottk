# Example from implot_demo.cpp
# void Demo_SubplotItemSharing()

proc sineWaveGetter {data len} {

    set l {}

    for {set i 0} {$i < $len} {incr i} {
        lappend l [list $i [expr {sin($data * $i)}]]
    }
    
    return $l
}

lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk

catch {console show}

# set frame
set f [implottk::implotFrame .f1 -width 800 -height 600]

# add options
$f options -title "Subplots Sharing"

set flags 32
set rows  3
set cols  3

# ImPlotSubplotFlags_ShareItems = 32
# ImPlotSubplotFlags_ColMajor   = 1024

# add cmds 'Imgui' on the fly
$f addImGUICmds {
    imgui::CheckboxFlags_UintPtr "ImPlotSubplotFlags_ShareItems" ::flags 32
    imgui::CheckboxFlags_UintPtr "ImPlotSubplotFlags_ColMajor"   ::flags 1024
    imgui::BulletText "%s" {string "Drag and drop items from the legend onto plots (except for 'common')"} 
}

set id {0 1 2 3 4 5}
set curj -1

# add cmds 'Implot' on the fly
$f addLinePlotCmds {
    if {[implot::BeginSubplots "##ItemSharing" $::rows $::cols {x -1 y -1} $::flags]} {
        for {set i 0} {$i < [expr {$::rows * $::cols}]} {incr i} {
            if {[implot::BeginPlot ""]} {
                set fc 0.01
                set len 1000
                set coords [sineWaveGetter $fc $len]
                implot::PlotLineG "common" $implot::cbplot NULL $len

                for {set j 0} {$j < 6} {incr j} {
                    if {[lindex $::id $j] == $i} {
                        set fj [expr {0.01 * ($j + 2)}]
                        set label "data${j}"
                        set coords [sineWaveGetter $fj $len]
                        implot::PlotLineG $label $implot::cbplot NULL $len
                        if {[implot::BeginDragDropSourceItem $label]} {
                            set ::curj $j
                            imgui::SetDragDropPayload "MY_DND" NULL 0
                            implot::GetLastItemColor lastitem_vec4
                            implot::ItemIcon_Vec4 $lastitem_vec4 ; imgui::SameLine
                            imgui::TextUnformatted $label
                            implot::EndDragDropSource
                        }
                    }
                }
                # drag and drop...
                if {[implot::BeginDragDropTargetPlot]} {
                    if {[cffi::pointer isvalid [imgui::AcceptDragDropPayload "MY_DND"]]} {
                        set ::id [lreplace $::id $::curj $::curj $i]
                    }

                    implot::EndDragDropTarget
                }
                implot::EndPlot
            }
        }
        implot::EndSubplots
    }
}

# Map Tk Frame
pack .f1 -fill both -expand 1