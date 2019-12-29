echo off
if not exist obj (
    mkdir obj
)
nasm IPL.nsm -o obj\IPL.bin
nasm FirstOS.nsm -o obj\FirstOS.bin
tools\edimg.exe imgin:tools\fdimg0at.tek wbinimg src:obj\IPL.bin len:512 from:0 to:0 copy from:obj\FirstOS.bin to:@: imgout:MyOS1.img