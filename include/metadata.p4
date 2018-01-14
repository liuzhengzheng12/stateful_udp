header_type sui_metadata_t {
    fields {
        op  : 1;
        sip : 32;
        dip : 32;
        sPort : 16;
        dPort : 16;
        ip_1 : 32;
        ip_2 : 32;
        port : 16;
        idx  : 16;
        xor_ip_1 : 32;
        xor_ip_2 : 32;
        xor_port : 16;
    }
}
metadata sui_metadata_t sui_meta;
