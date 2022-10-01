## Build instructions  :
**Note** : _First of all I’m not an expert on compilation, and I discovered what a _CMakeLists.txt_ file was with this project, so if you have any problems, please don’t call me_ :wink:. 

To use `implotTk`, you need to have a `c-api wrapper` , you can find [here](https://github.com/cimgui/cimgui) for `Dear imgui` and [here](https://github.com/cimgui/cimplot) for `Implot`.  
To works `Dear imgui` and `Implot` use backends, my choice was on :
-  `OpenGL` and `Win32`

If like me the compilation is a _desert_, I advise you to use [LuaJIT-ImGui](https://github.com/sonoro1234/LuaJIT-ImGui) 

Below are the steps that allowed me to generate a c-api wrapper for `implotTk`
 1. Cloning
```
git clone --recurse-submodules https://github.com/sonoro1234/LuaJIT-ImGui.git
```
2. Edit the file _CMakeLists.txt_ and modify this lines :

| line | Value | 
| ------ | ------
| option(IMPL_GLFW "add GLFW implementation"       | OFF 
| option(IMPL_SDL "add SDL implementation"         | OFF
| option(IMPL_OPENGL2 "add OPENGL2 implementation" | OFF
| option(IMPL_OPENGL3 "add OPENGL3 implementation" | ON 
| option(IMGUI_FREETYPE "add Freetype2"            | OFF
| option(IMPL_EXTRAS "knob and curve"              | OFF

Add this lines :
```
set(arch x64)

option(IMPL_WIN32 "WIN32 implementation" ON)

if(IMPL_WIN32)
    list(APPEND IMGUI_SOURCES_win32 ${BAKENDS_FOLDER}imgui_impl_win32.cpp)
	add_library(cimgui_${arch} SHARED ${IMGUI_SOURCES_win32} $<TARGET_OBJECTS:cimgui_base>)
	# target_link_libraries(cimgui_${arch} PUBLIC ${IMGUI_LIBRARIES} win32)
	install(TARGETS cimgui_${arch}
              RUNTIME DESTINATION  ${LUAJIT_BIN}
              LIBRARY DESTINATION  ${LUAJIT_BIN}
              #ARCHIVE DESTINATION lib 
              )
endif(IMPL_WIN32)
```
3. Compile and good luck... :pray:
4. For `32 bits` version , place cimgui_x86.dll in this folder (/lib/x86/) , for `64 bits` version, place cimgui_x64.dll in this folder (/lib/amd64/)
