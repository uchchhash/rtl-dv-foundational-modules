#echo -e "" "" "" 
#read delay tes mode

#echo "tests :: reset : set : lshift : rshift : hold : random"
#echo -e "test = " 
#read tes

#echo -e "run in :: batch mode | gui mode | covmode? : " 
#read mode
#echo $mode

#rm -rf INCA_libs

if [ -d ./INCA_libs ]; then
  echo "directory exists"
  rm -rf INCA_libs
fi

if [ "$1" == "gui" ]; then
    irun -f filelist_new.f -access +rwc -timescale 1ns/10ps +delay=$3 +$2 -gui

elif [ "$1" = "batch" ]; then
    irun -f filelist_new.f -access +rwc -timescale 1ns/10ps +delay=$3 +$2

elif [ "$1" = "covmode" ]; then
    irun -f filelist_new.f -access +rwc -timescale 1ns/10ps +delay=$3 +$2 +$1 -covtest $2 -coverage all

else
    irun -f filelist_new.f -access +rwc -timescale 1ns/10ps
fi 


