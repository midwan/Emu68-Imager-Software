/* ParseEmu68Boot.rexx                *
*                                     *
* ARexx Parser for Emu68BOOT Device   *
*                                     */

PARSE ARG target_driver

IF target_driver = "" THEN DO
    SAY "Usage: rx ParseEmu68Boot.rexx <drivername>"
    EXIT 10
END

filename = "T:DriveInfo.txt"
address command 'SYS:Pistorm/Emu68UpdaterFiles/doslist >' filename

if ~open(inf, filename, 'R') then exit 10

active = 0
found_count = 0
first_device = ""

do while ~eof(inf)
    line = readln(inf)
    
    select
        when pos('Device: "', line) > 0 then do
            parse var line 'Device: "' device '"' .
            dname = ""
            active = 1 
        end

        when pos('No environment vector', line) > 0 then active = 0

        when active & pos('Device name is "', line) > 0 then do
            parse var line 'is "' dname '"' .
        end

        when active & pos('DosType is', line) > 0 then do
            if upper(dname) = upper(target_driver) then do
                found_count = found_count + 1
                if found_count = 1 then first_device = device
            end
            active = 0
        end
        otherwise nop
    end
end

close(inf)

ADDRESS COMMAND 'delete 'filename' QUIET >NIL:' 

if found_count >= 1 then DO
   ADDRESS COMMAND 'SETENV EMU68BootDrive 'first_device
   say first_device
END

/* Exit logic based on match count */
if found_count = 1 then do
    exit 0
end

/* Exit 5 if none found OR more than one found */
exit 5