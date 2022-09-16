# Copyright (c) 2022 Nicolas ROBERT.
# Distributed under MIT license. Please see LICENSE for details.

cffi::alias define ImBitArrayForNamedKeys   {uchar[512]}
cffi::alias define ImDrawIdx                ushort
cffi::alias define ImFileHandle             pointer.FILE
cffi::alias define ImGuiID                  uint
cffi::alias define ImPoolIdx                int
cffi::alias define ImS16                    short
cffi::alias define ImS32                    int
cffi::alias define ImS64                    longlong
cffi::alias define ImS8                     schar
cffi::alias define ImTextureID              pointer
cffi::alias define ImU16                    ushort
cffi::alias define ImU32                    uint
cffi::alias define ImU64                    ulonglong
cffi::alias define ImU8                     uchar
cffi::alias define ImWchar16                ushort
cffi::alias define ImWchar32                uint
cffi::alias define ImWchar                  ImWchar16
cffi::alias define ImGuiTableColumnIdx      ImS8
cffi::alias define ImGuiTableDrawChannelIdx ImU8
cffi::alias define ImVector_ImU32           ImU32
cffi::alias define ImVector_ImDrawIdx       ImDrawIdx

# define bool as type for struct
cffi::alias define ImBool                   int
# define bool as type for function
cffi::alias define CIMGUI_BOOL              uchar


# cffi::alias define ImGuiMemAllocFunc void*(*)(size_t sz,void* user_data);
# cffi::alias define ImGuiMemFreeFunc void(*)(void* ptr,void* user_data);
# cffi::alias define const_iterator const value_type*
# cffi::alias define iterator value_type*
# cffi::alias define value_type T
