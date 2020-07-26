echo off
if not exist obj (
    mkdir obj
)
nasm IPL.nsm -o obj\IPL.bin
nasm entry.nsm -o obj\entry.bin
nasm nasm_func.nsm -f coff -o obj\nasm_func.obj

gcc kernel.c -c 
move kernel.o obj\kernel.obj
tools\obj2bim.exe @tools\obj2bim.rul out:obj\kernel.bim stack:3136k map:obj\kernel.map obj\kernel.obj obj\nasm_func.obj
tools\bim2hrb.exe obj\kernel.bim obj\kernel.hrb 0
copy /B obj\entry.bin+obj\kernel.hrb obj\MyOS.sys

tools\edimg.exe   imgin:tools\fdimg0at.tek   wbinimg src:obj\IPL.bin len:512 from:0 to:0 copy from:obj\MyOS.sys   to:@: imgout:MyOS.img