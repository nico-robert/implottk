# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::win32 {
    variable cb
    
    cffi::Wrapper create USER32 user32.dll

    USER32 function GetDC               pointer.HDC  {hwnd pointer.HWND}
    USER32 function SetForegroundWindow BOOL         {hwnd pointer.HWND}
    USER32 function SetActiveWindow     pointer.HWND {hwnd pointer.HWND}
    USER32 function SetFocus            pointer.HWND {hwnd pointer.HWND}
    
    if {$::tcl_platform(machine) eq "amd64"} {
        USER32 function SetWindowLongPtrA LONG_PTR {
            hwnd pointer.HWND
            nIndex {int {
                    enum {
                        GWL_EXSTYLE   -20
                        GWL_HINSTANCE -6
                        GWL_ID        -12
                        GWL_STYLE     -16
                        GWL_USERDATA  -21
                        GWL_WNDPROC   -4
                    }
                }
            }
            callback pointer.Wndproc
        }
       
        set SWLPA LONG_PTR
    } else {
        USER32 function SetWindowLongA LONG {
            hwnd pointer.HWND
            nIndex {int {
                    enum {
                        GWL_EXSTYLE   -20
                        GWL_HINSTANCE -6
                        GWL_ID        -12
                        GWL_STYLE     -16
                        GWL_USERDATA  -21
                        GWL_WNDPROC   -4
                    }
                }
            }
            callback pointer.Wndproc
        }
        
        set SWLPA LONG
    }

    USER32 function DefWindowProcA LRESULT {
        hWnd   pointer.HWND
        msg    UINT
        wParam WPARAM
        lParam LPARAM
    }

    cffi::prototype function Wndproc $SWLPA {
        hWnd   {pointer.HWND unsafe}
        msg    UINT
        wParam WPARAM
        lParam LPARAM
    }

    proc WndProcHandler {hWnd msg wParam lParam} {
        
        # Debug...
        # puts "hWnd: $hWnd msg: [format 0x%X $msg] ($msg) wParam: $wParam lParam: $lParam"

        if {[imgui::ImplWin32_WndProcHandler $hWnd $msg $wParam $lParam]} {
            return 1
        }

        return [win32::DefWindowProcA $hWnd $msg $wParam $lParam]
    }

    set cb [cffi::callback new Wndproc win32::WndProcHandler 0]
}

