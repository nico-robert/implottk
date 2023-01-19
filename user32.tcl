# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::user32 {
    variable cb
    
    cffi::Wrapper create USER32 user32.dll

    cffi::enum define gwlenum_ {
        GWL_EXSTYLE   -20
        GWL_HINSTANCE -6
        GWL_ID        -12
        GWL_STYLE     -16
        GWL_USERDATA  -21
        GWL_WNDPROC   -4
    }

    cffi::alias define GWLenum {int {enum gwlenum_}}

    USER32 function GetDC pointer.HDC  {
        hwnd pointer.HWND
    }

    USER32 function SetForegroundWindow BOOL {
        hwnd pointer.HWND
    }

    USER32 function SetActiveWindow pointer.HWND {
        hwnd pointer.HWND
    }

    USER32 function SetFocus pointer.HWND {
        hwnd pointer.HWND
    }

    USER32 function SetParent pointer.HWND {
        hWndChild     pointer.::user32::HWND
        hWndNewParent pointer.::user32::HWND
    }
    
    if {$::tcl_platform(machine) eq "amd64"} {
        USER32 function SetWindowLongPtrA LONG_PTR {
            hwnd pointer.HWND
            nIndex GWLenum
            callback pointer.Wndproc
        }
        
        USER32 function SetWindowLongPtrW LONG_PTR {
            hwnd pointer.HWND
            nIndex GWLenum
            dwNewLong LONG_PTR
        }
        
        USER32 function GetWindowLongPtrA LONG_PTR {
            hwnd pointer.HWND
            nIndex GWLenum
        }
       
        set SWLPA LONG_PTR
    } else {
        USER32 function SetWindowLongA LONG {
            hwnd pointer.HWND
            nIndex GWLenum
            callback pointer.Wndproc
        }
        
        USER32 function SetWindowLongW LONG {
            hwnd pointer.HWND
            nIndex GWLenum
            dwNewLong LONG
        }
        
        USER32 function GetWindowLongA LONG {
            hwnd pointer.HWND
            nIndex GWLenum
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

    USER32 function FindWindowExA pointer.HWND {
        hWndParent     {pointer.HWND nullok}
        hWndChildAfter {pointer.HWND nullok}
        lpszClass      {pointer.LPCSTR nullok}
        lpszWindow     {pointer.LPCSTR nullok}
    }

    cffi::prototype function WndEnumProc BOOL {
        hWnd   {pointer.HWND unsafe}
        lParam LPARAM
    }

    USER32 function EnumChildWindows BOOL {
        hWndParent {pointer.HWND nullok}
        callback   pointer.WndEnumProc
        lParam     LPARAM
    }

    USER32 function GetWindowTextA int {
        hWnd      pointer.HWND
        lpString  {chars[nMaxCount] out}
        nMaxCount {int {default 255}}
    }

    set cbenumWindows [cffi::callback new WndEnumProc implottk::EnumChildProc  0]
    set cb            [cffi::callback new Wndproc     implottk::WndProcHandler 0]
}

