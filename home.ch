# Trash App
use tk
AppIcon: icon.png
OnDisplay: @gua
Background: bg.png
main_text_color: #FFFAFF

Width: 400
Size: 200
Title: Restore Deleted apps

Text.nb: 1
Text1: Deleted App List
Text1.id: 3
3.x: 60
3.y: 0

buttons.nb: 2
Button1: Restore App
Button1.id: 0
0.x: 30
0.y: 100
0.link: @restore

Button2: Delete App
Button2.id: 1
1.x: 30
1.y: 125
1.link: @remove

button.width: 150

#Get Uninstalled Apps
[@gua]
ConfigButton 0 fg='#FFFFFF', bg='#00AA00'
ConfigButton 1 fg='#FFFFFF', bg='#AA0000'
ReadFile C:\GC\installed\deleted.dat
evaluate [x.split('\\')[-1].strip() for x in {LASTRESULT}.split('\n') if x != '' and x[0] != "#"]
evaluate list( set( {LASTRESULT} ) )
SetVar *del LASTRESULT
create ListBox with *del
end
[/@gua]

#Restore deleted app
[@restore]
check var SELECTED
if 1 then
	add SELECTED _deleted
	evaluate system("move \"C:\\GC\\installed\\"+{LASTRESULT}+"\" \"C:\\GC\\installed\\"+{SELECTED}+"\"")
	evaluate open('C:\\GC\\installed\\deleted.dat', 'w')=>*file
	evaluate {*del}.remove({SELECTED})
	evaluate '\n'.join({*del})
	evaluate {*file}.write({LASTRESULT})
	evaluate {*file}.close()
	execute function ra with "C:\\GC\\installed\\"+self.vars.getvar("SELECTED")+"\\"
	#evaluate ch_update({SELECTED}+" C:\\GC\\installed\\"+{SELECTED}+"\\", "C:\\GC\\installed\\installed.dat")
	MessageBox Done App restored!
	load home.ch
	end
MessageBox Error no app selected!
end
[/@restore]

#Forget deleted apps
[@remove]
check var SELECTED
if 1 then
	if evaluate( not messagebox.askyesno("Confirmation", "Are you sure you want to delete "+str({SELECTED})+" forever ?") ) then
		end
	add SELECTED _deleted
	evaluate system("rmdir /S /Q \"C:\\GC\\installed\\"+{LASTRESULT}+"\"")
	evaluate open('C:\\GC\\installed\\deleted.dat', 'w')=>*file
	evaluate {*del}.remove({SELECTED})
	evaluate '\n'.join({*del})
	evaluate {*file}.write({LASTRESULT})
	evaluate {*file}.close()
	MessageBox Done App deleted forever!
	load home.ch
	end
MessageBox Error no app selected!
end
[/@remove]

LB.x: 10
LB.y: 50

#END
