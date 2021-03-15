
for dir in  `find . -maxdepth 1 -mindepth 1 -type d -printf '%f\n' | grep -v Train_Arma`
do
  echo runing $dir
  cd $dir
  qsub qsub.sh
  cd ..
done





