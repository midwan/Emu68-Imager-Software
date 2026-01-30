/* ParseEmu68Boot.rexx                *
*                                     *
* ARexx Parser for Emu68BOOT Device   *
*                                     */

DeviceListPath = 'C:ListDevices'
Drivername1 = 'brcm-emmc.device'
Drivername2 = 'brcm-sdhc.device'
TargetDostype = '46415401'

filename = "T:DriveInfo.txt"
filename2 = "T:Emu68FilesLocation.txt"


address command DeviceListPath 'device_name='Drivername1','Drivername2' NOFORMATTABLE >'filename 


if ~open(inf, filename, 'R') then DO
   SAY "Error accessing list of drives!"
   exit 10
end

found_count = 0
first_device = ""

do while ~eof(inf)
    line = readln(inf)
    parse var line vDevice';'vRawDosType';'vDosType';'vDeviceName';'vUnit';'vVolume
    found_count = found_count + 1
    if found_count = 1 then first_device = vDevice':'
end
  
close(inf)


ADDRESS COMMAND 'delete 'filename' QUIET >NIL:' 

If found_count = 0 then DO
   SAY "No device found!"
   EXIT 10
end

ADDRESS COMMAND 'list all files 'first_device' Pat=(Emu68-pistorm#?) Lformat="%p" >'filename2

if ~open(inf, filename2, 'R') then DO
   SAY "Cannot open list of files!"
   exit 10
END

captured_line = ""

do while ~eof(inf)
    line = strip(readln(inf))
    if line = "" | eof(inf) then iterate   
    if captured_line ~= line & captured_line ~="" then do
       SAY "Multiple locations for Emu68 files!"
       close(inf)
       ADDRESS COMMAND 'delete 'filename' QUIET >NIL:' 
       EXIT 10
    end
    captured_line = line
end

close(inf)

ADDRESS COMMAND 'delete 'filename' QUIET >NIL:' 

if captured_line = "" then DO
  say "File was empty."
  EXIT 10
end


Emu68FilePath = captured_line

ADDRESS COMMAND 'SETENV EMU68FilePath 'Emu68FilePath


EXIT 0