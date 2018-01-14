field_list hash_fields_0 {
    sui_meta.sip;
    sui_meta.dip;
    sui_meta.sPort;
}

field_list_calculation hash0 {
    input {
        hash_fields_0;
    }
    algorithm : crc32;
    output_width : 16;
}

field_list hash_fields_1 {
    sui_meta.dip;
    sui_meta.sip;
    sui_meta.dPort;
}

field_list_calculation hash1 {
    input {
        hash_fields_1;
    }
    algorithm : crc32;
    output_width : 16;
}
