# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::implottk {

    set frameOpts {
        -width      50
        -height     50
    }
    
    variable imFrame [dict create {*}$frameOpts]
            
    # class widget
    oo::class create widget {
        variable _series            ; # num serie
        variable _cmdplot           ; # list commands implot
        variable _cmdimgui          ; # list commands imgui
        variable _cmdstyle          ; # list commands imgui style
        variable _lenCmdstyle       ; # len  commands imgui style
        variable _cmdplotstyle      ; # configure style plot
        variable _lencmdplotstyle   ; # len commands implot style
        variable _titleplot         ; # title plot (default not visible)
        
        superclass lineSeries imgui
        
        constructor {} {
            set _series          {}
            set _cmdplot         {}
            set _cmdimgui        {}
            set _cmdstyle        {}
            set _cmdplotstyle    {}
            set _lenCmdstyle     0
            set _lencmdplotstyle 0
            set _titleplot "##title"
        }
    }

    oo::define widget {
        method title {} {
            return $_titleplot
        }
        
        method options {args} {
        
            foreach {key value} $args {
                if {$value eq ""} {
                    error "No value specified for key '$key'"
                }
                
                switch -exact -- $key {
                    -fonts {
                        if {[llength $value] != 2} {
                            error {list value should be -fonts [list 'fullpathname' 'size']}
                        }
                        
                        lassign $value pathname size
                        
                        if {![file exists $pathname]} {
                            error "$pathname doesn't exists..."
                        }
                        
                        if {![string is integer $size] || $size <= 0} {
                            error "Size font should be greater than 0"
                        }
                        
                        set sf [imgui::ImGuiIO getnative [my getIo] Fonts]
                        imgui::ImFontAtlas_AddFontFromFileTTF $sf $pathname $size
                    
                    }
                    -color {
                    
                        set _options [dict create]
                    
                        foreach {keycolor valuecolor} $value {
                            if {$valuecolor eq ""} {
                                error "No value specified for subkey '$keycolor'"
                            }
                            
                            if {[llength $valuecolor] != 3} {
                                error "list color should be equal to 3..."
                            }         
                            
                            switch -exact -- $keycolor {
                                windowBackground {dict set _options ImGuiCol_WindowBg $valuecolor}
                                popupBackground  {dict set _options ImGuiCol_PopupBg  $valuecolor}
                                text             {dict set _options ImGuiCol_Text     $valuecolor}
                                default          {error "Unknown subkey '$keycolor' specified"}
                            }
                        }
                        
                        set _cmdstyle {}
                                                
                        dict for {key info} $_options {
                            lappend _cmdstyle [list imgui::PushStyleColor_Vec4 $key [implottk::rgbaToVec4 $info]]
                        }
                        
                        set _lenCmdstyle [llength $_cmdstyle]
                        
                    }
                    
                    -colorPlot {
                        set _options [dict create]
                    
                        foreach {keycolor valuecolor} $value {
                            if {$valuecolor eq ""} {
                                error "No value specified for subkey '$keycolor'"
                            }
                            
                            if {[llength $valuecolor] != 3} {
                                error "list colorPlot should be equal to 3..."
                            }         

                            switch -exact -- $keycolor {
                                plotBackground   {dict set _options ImPlotCol_PlotBg     $valuecolor}
                                frameBackground  {dict set _options ImPlotCol_FrameBg    $valuecolor}
                                axisText         {dict set _options ImPlotCol_AxisText   $valuecolor}
                                legendBackground {dict set _options ImPlotCol_LegendBg   $valuecolor}
                                legendText       {dict set _options ImPlotCol_LegendText $valuecolor}
                                default          {error "Unknown subkey '$keycolor' specified"}
                            }
                        }
                        
                        set _cmdplotstyle {}
                                                
                        dict for {key info} $_options {
                            lappend _cmdplotstyle [list implot::PushStyleColor_Vec4 $key [implottk::rgbaToVec4 $info]]
                        }
                        
                        set _lencmdplotstyle [llength $_cmdplotstyle]
                    }
                    
                    -title {set _titleplot $value}
                    -axisName {
                    
                        if {[llength $value] != 2} {
                            error "label Axis should be equal to 2..."
                        }    

                        lappend _cmdplot [list implot::SetupAxes {*}$value]
                    }

                    default {error "Unknown key '$key' specified"}
                }
            }
            
            # add default font...
            if {![dict exists $args -font]} {
                set iofonts [imgui::ImGuiIO getnative [my getIo] Fonts]
                imgui::ImFontAtlas_GetTexDataAsRGBA32 $iofonts NULL testx testy NULL
            }
            
        }
        
        method getIo {} {
            # Access the IO structure 
            # (mouse/keyboard/gamepad inputs, time, various configuration options/flags)
            #
            # Returns IO struct
            return [imgui::GetIO]
        }

        method cmdPlot {} {
            # Returns commands implot
            return $_cmdplot
        }
        
        method cmdImGUI {} {
            # Returns commands imgui
            return $_cmdimgui
        }
        
        method cmdStyle {} {
            # Returns commands imgui style
            return [list $_cmdstyle [list imgui::PopStyleColor $_lenCmdstyle]]
        }
        
        method cmdplotStyle {} {
            # Returns commands implot style
            return [list $_cmdplotstyle [list implot::PopStyleColor $_lencmdplotstyle]]
        }

    }
}

proc ::implottk::implotFrameLoop {oow dc rc io p {focus 0}} {
    # Event loop implottk
    #
    # oow   - frame object
    # dc    - handle to a device context
    # rc    - opengl context
    # io    - struct imgui
    # p     - frame pointer
    # focus - boolean value to valid or not win32 focus
    #
    # Returns nothing
    variable id
    
    if {$focus} {
        update idletasks
        user32::SetFocus $p
    }

    imgui::ImplOpenGL3_NewFrame
    imgui::ImplWin32_NewFrame
    imgui::NewFrame
    
    # Get struct imgui Viewport
    set viewport [imgui::GetMainViewport]

    set workpos  [imgui::ImGuiViewport getnative $viewport WorkPos]
    set worksize [imgui::ImGuiViewport getnative $viewport WorkSize]
    
    # Set full screen in tk frame
    imgui::SetNextWindowPos  $workpos  ImGuiCond_None {x 0 y 0}
    imgui::SetNextWindowSize $worksize ImGuiCond_None
    
    # add style ImGui if exists...
    foreach colorStyle [lindex [$oow cmdStyle] 0] {
        uplevel #0 $colorStyle
    }

    imgui::Begin "implottk" NULL {
                             ImGuiWindowFlags_NoDecoration
                             ImGuiWindowFlags_NoMove
                             ImGuiWindowFlags_NoSavedSettings
                            }

    # add style Implot if exists...
    foreach colorPlotStyle [lindex [$oow cmdplotStyle] 0] {
        uplevel #0 $colorPlotStyle
    }
    
    # add commands imgui
    foreach cmd [$oow cmdImGUI] {
        uplevel #1 $cmd
    }
    
    # add commands implot
    if {[llength [$oow cmdPlot]]} {
        # add commands implot without 'implot::BeginPlot'
        if {[lsearch [$oow cmdPlot] {*implot::BeginPlot*}] == -1} {
            if {[implot::BeginPlot [$oow title]]} {
                foreach cmd [$oow cmdPlot] {
                    uplevel #1 $cmd
                }
                implot::EndPlot
            }
        # add commands implot with 'implot::BeginPlot'
        } elseif {[lsearch [$oow cmdPlot] {*implot::BeginPlot*}] > -1} {
            foreach cmd [$oow cmdPlot] {
                uplevel #1 $cmd
            }
        } else {
            error "PLot should start with 'BeginPlot' instruction..."
        }
    }
    
    # set style ImPlot if exists...
    uplevel #0 [lindex [$oow cmdplotStyle] 1]

    imgui::End
    
    # set style ImGui if exists...
    uplevel #0 [lindex [$oow cmdStyle] 1]
    
    imgui::Render
    
    set w [string range $oow 10 end]

    gl::glViewport   0 0 [winfo width $w] [winfo height $w]
    gl::glClearColor 1.0 1.0 1.0 0.0
    gl::glClear      {GL_COLOR_BUFFER_BIT GL_DEPTH_BUFFER_BIT}

    imgui::ImplOpenGL3_RenderDrawData [imgui::GetDrawData]
    
    gl::wglMakeCurrent $dc $rc
    gl::glFlush
    
    # Viewports
    set configFlags [imgui::ImGuiIO getnative $io ConfigFlags]
    
    if {[dict exists $configFlags ImGuiConfigFlags_ViewportsEnable]} {
        imgui::UpdatePlatformWindows
        imgui::RenderPlatformWindowsDefault
    }
        
    gdi::SwapBuffers $dc

    set id($oow) [after 10 [list implottk::implotFrameLoop $oow $dc $rc $io $p]]

    return {}
}

proc ::implottk::implotFrameResize {w h dc rc} {
    # Resize frame when this is configured.
    #
    # w  - width
    # h  - height
    # dc - handle to a device context
    # rc - opengl context
    #
    # Returns nothing

    update idletasks

    gl::glViewport 0 0 $w $h
    gl::wglMakeCurrent $dc $rc
    gl::glFlush
    gdi::SwapBuffers $dc

    return {}

}

proc ::implottk::implotCancel {oow} {
    # Cancel event loop
    #
    # oow - frame object
    #
    # Returns nothing
    variable id

    after cancel $id($oow)

    return {}
}

proc ::implottk::implotFrameDestroy {oow ctx} {
    # Destroy frame
    #
    # oow - frame object
    # ctx - imgui context
    #
    # Returns nothing

    # cancel before destroy
    implottk::implotCancel $oow

    imgui::ImplOpenGL3_Shutdown
    imgui::ImplWin32_Shutdown
    imgui::DestroyContext $ctx

    return {}
}

proc ::implottk::implotFrame {w args} {
    # Make frame implot + imgui
    #
    # w - frame Tk
    # args - see description below
    #        -width  : size frame
    #        -height : size frame
    #
    # Returns frame object 

    foreach {key value} $args {
        if {$value eq ""} {
            error "No value specified for key '$key'"
        }
        
        switch -exact -- $key {
            "-width"      {dict set ::implottk::imFrame -width     $value}
            "-height"     {dict set ::implottk::imFrame -height    $value}
            default       {error "Unknown key '$key' specified"}
        }
    }
   
    # create frame
    # I’m not sure if -container's flag is useful...
    frame $w -container 1 \
             -width      [dict get $::implottk::imFrame -width] \
             -height     [dict get $::implottk::imFrame -height] \
             -class      ImPlot

    set oow implottk::$w
  
    set p [cffi::pointer make [winfo id $w] ::user32::HWND]
    cffi::pointer safe $p
    
    # retrieves a handle to a device context
    set dc [user32::GetDC $p]
    
    gdi::setPixelFormat $p $dc
    
    # opengl
    set rc [gl::wglCreateContext $dc]
    gl::wglMakeCurrent $dc $rc
    
    # context
    set ctx     [imgui::CreateContext]  ; #imgui
    set ctxplot [implot::CreateContext] ; #implot
    
    imgui::SetCurrentContext $ctx
    implot::SetImGuiContext   $ctx
    
    implot::SetCurrentContext $ctxplot
    
    set io [imgui::GetIO]
    
    # Time elapsed since last frame, in seconds
    imgui::ImGuiIO setnative $io DeltaTime [expr {1 / 60.0}]

    # Viewports
    # imgui::ImGuiIO setnative $io ConfigFlags {ImGuiConfigFlags_ViewportsEnable}
    
    imgui::ImplWin32_Init $p
    imgui::ImplOpenGL3_Init
    
    # Callback message imgui -> Windows
    if {$::tcl_platform(machine) eq "amd64"} {
        user32::SetWindowLongPtrA $p GWL_WNDPROC $user32::cb
    } else {
        user32::SetWindowLongA $p GWL_WNDPROC $user32::cb
    }
    
    bind $w <Configure> [list implottk::implotFrameResize  %w %h $dc $rc]
    bind $w <Map>       [list implottk::implotFrameLoop    $oow $dc $rc $io $p 1]
    bind $w <Unmap>     [list implottk::implotCancel       $oow]
    bind $w <Destroy>   [list implottk::implotFrameDestroy $oow $ctx]

    return [implottk::widget create $oow]
    
}