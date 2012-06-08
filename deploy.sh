
cd pkg
rm -rf *
cd ..
rake gem
cd pkg
gem uninstall freightrain
gem install -l freightrain-0.8.5.gem
