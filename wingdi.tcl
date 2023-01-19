# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

namespace eval ::gdi {

    cffi::Wrapper create GDI32 gdi32.dll

    GDI32 function ChoosePixelFormat int {hdc pointer.::user32::HDC ppfd pointer.PIXELFORMATDESCRIPTOR}
    GDI32 function SetPixelFormat    int {hdc pointer.::user32::HDC format int ppfd pointer.PIXELFORMATDESCRIPTOR}
    GDI32 function SwapBuffers       int {hdc pointer.::user32::HDC}

    cffi::enum define dwFlags_ {
        PFD_DRAW_TO_WINDOW      0x00000004
        PFD_DRAW_TO_BITMAP      0x00000008
        PFD_SUPPORT_GDI         0x00000010
        PFD_SUPPORT_OPENGL      0x00000020
        PFD_GENERIC_ACCELERATED 0x00001000
        PFD_GENERIC_FORMAT      0x00000040
        PFD_NEED_PALETTE        0x00000080
        PFD_NEED_SYSTEM_PALETTE 0x00000100
        PFD_DOUBLEBUFFER        0x00000001
        PFD_STEREO              0x00000002
        PFD_SWAP_LAYER_BUFFERS  0x00000800
    }

    cffi::alias define GDIDwFlags {DWORD {enum dwFlags_}}

    cffi::Struct create PIXELFORMATDESCRIPTOR {
      nSize                 WORD  
      nVersion              WORD  
      dwFlags               {GDIDwFlags bitmask}
      iPixelType            BYTE  
      cColorBits            BYTE  
      cRedBits              BYTE  
      cRedShift             BYTE  
      cGreenBits            BYTE  
      cGreenShift           BYTE  
      cBlueBits             BYTE  
      cBlueShift            BYTE  
      cAlphaBits            BYTE  
      cAlphaShift           BYTE  
      cAccumBits            BYTE  
      cAccumRedBits         BYTE  
      cAccumGreenBits       BYTE  
      cAccumBlueBits        BYTE  
      cAccumAlphaBits       BYTE  
      cDepthBits            BYTE  
      cStencilBits          BYTE  
      cAuxBuffers           BYTE  
      iLayerType            BYTE  
      bReserved             BYTE  
      dwLayerMask           DWORD 
      dwVisibleMask         DWORD 
      dwDamageMask          DWORD 
    }

}


proc ::gdi::setPixelFormat {p dc} {

    set pfd [gdi::PIXELFORMATDESCRIPTOR allocate]

    gdi::PIXELFORMATDESCRIPTOR setnative $pfd nVersion 1
    gdi::PIXELFORMATDESCRIPTOR setnative $pfd dwFlags {PFD_DRAW_TO_WINDOW PFD_SUPPORT_OPENGL PFD_DOUBLEBUFFER}
    gdi::PIXELFORMATDESCRIPTOR setnative $pfd iPixelType 0
    gdi::PIXELFORMATDESCRIPTOR setnative $pfd cColorBits 24
    gdi::PIXELFORMATDESCRIPTOR setnative $pfd cDepthBits 16
    gdi::PIXELFORMATDESCRIPTOR setnative $pfd iLayerType 0

    set pixelFormat [ChoosePixelFormat $dc $pfd]

    SetPixelFormat $dc $pixelFormat $pfd

}