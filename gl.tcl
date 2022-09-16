# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.s

namespace eval ::gl {
    
    cffi::Wrapper create GL opengl32.dll

    cffi::enum define glenum_ {
        GL_LIGHTING             0x0B50
        GL_TEXTURE_2D           0x0DE1
        GL_CULL_FACE            0x0B44
        GL_ALPHA_TEST           0x0BC0
        GL_BLEND                0x0BE2
        GL_STENCIL_TEST         0x0B90
        GL_DEPTH_TEST           0x0B71
        GL_LIGHT0               0x4000
        GL_LIGHT1               0x4001
        GL_POINT_SMOOTH         0x0B10
        GL_LINE_STIPPLE         0x0B24
        GL_LINE_SMOOTH          0x0B20
        GL_SCISSOR_TEST         0x0C11
        GL_COLOR_MATERIAL       0x0B57
        GL_NORMALIZE            0x0BA1
        GL_RESCALE_NORMAL       0x803A
        GL_POLYGON_OFFSET_FILL  0x8037
        GL_POLYGON_STIPPLE      0x0B42
        GL_VERTEX_ARRAY         0x8074
        GL_NORMAL_ARRAY         0x8075
        GL_COLOR_ARRAY          0x8076
        GL_TEXTURE_COORD_ARRAY  0x8078
    }

    cffi::alias define GLenum {DWORD {enum glenum_}}

    GL function glClearColor         void          {r float g float b float a float}
    GL function glClear              void          {value int}
    GL function glViewport           void          {x int y int width int height int}
    GL function glEnable             void          {cap GLenum}
    GL function glBlendFunc          void          {sfactor int dfactor int}
    GL function glClearDepth         void          {depth float}
    GL function glCullFace           void          {mode int}
    GL function glMatrixMode         void          {mode int}
    GL function glLoadIdentity       void          {}
    GL function glRotatef            void          {angle float x float y float z float}
    GL function glBegin              void          {mode int}
    GL function glVertex3f           void          {x float y float z float}
    GL function glColor3f            void          {r float g float b float}
    GL function glOrtho              void          {v1 float v2 float v3 float v4 float v5 float v6 float}
    GL function glEnd                void          {}
    GL function glFlush              void          {}
    GL function wglCreateContext     pointer.HGLRC {win pointer.::win32::HDC}
    GL function wglMakeCurrent       int           {hdc pointer.::win32::HDC hglrc pointer.HGLRC}
    GL function wglGetCurrentContext pointer.HGLRC {}
    GL function wglShareLists        BOOL {hglrc1 pointer.HGLRC hglrc2 pointer.HGLRC}    
    
}


