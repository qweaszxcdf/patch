wget https://raw.githubusercontent.com/aria2/aria2/master/Dockerfile.mingw
INPUT=Dockerfile.mingw
OUTPUT=Dockerfile.sh
cp -f $INPUT $OUTPUT
sed -i "s/^FROM\s/# FROM /g" $OUTPUT
sed -i "s/^MAINTAINER\s/# MAINTAINER /g" $OUTPUT
sed -i "s/^VOLUME\s/# VOLUME /g" $OUTPUT
sed -i "s/^RUN\s//g" $OUTPUT
sed -r 's/^ENV\s([A-Z]*)\s*([a-z]*)/export \1=\2/g' -i $OUTPUT
sed -i "s/^ADD.*//g" $OUTPUT
sed -i '1s/^/# Generated by docker_to_sh, for all your shoddy bash script from Dockerfile generation needs. \n/' $OUTPUT
sed -i 's/apt-get/sudo\ apt-get/g' $OUTPUT
sed -i 's/i686-w64-mingw32/x86_64-w64-mingw32/g' $OUTPUT
sed -i 's/tar/cd \$GITHUB_WORKSPACE \&\& tar/g' $OUTPUT
sed -i 's/cd aria2/cd aria2 \&\& git am  \.\.\/\*\.patch/g' $OUTPUT
bash ./Dockerfile.sh
