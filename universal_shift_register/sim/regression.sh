#rm -rf cov_work

#testlist="test.txt"

#while read -r line;
#do
#    irun -f filelist_new.f -timescale 1ns/10ps +delay=10 +covmode +$line -coverage all -covtest $line
#done < "$testlist"
if [ -d ./cov_work ]; then
  echo "directory exists"
  rm -rf cov_work
fi

testlist="test.txt"

 while read -r line;
  do
      irun -f filelist_new.f -timescale 1ns/10ps +delay=10 +covmode +$line -coverage all -covtest $line -covoverwrite
  done < "$testlist"
