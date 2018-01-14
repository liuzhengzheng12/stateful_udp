cp stateful_udp_inspector.conf $SDE_INSTALL/share/p4/targets/
cd $SDE/pkgsrc/p4-build-4.1.1.15
./configure --prefix=$SDE_INSTALL --with-tofino P4_NAME=stateful_udp_inspector P4_PATH=~/stateful_udp_inspector/stateful_udp_inspector.p4 --enable-thrift
make -j4
make install