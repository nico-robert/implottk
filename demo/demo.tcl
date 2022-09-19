# Demo implot with all plots

lappend auto_path [file dirname [file dirname [file dirname [info script]]]]

package req implottk

catch {console show}

set f [implottk::implotFrame .f1 -width 500 -height 400]

$f addImGUICmds {
    implot::ShowDemoWindow
}

pack .f1 -fill both -expand 1