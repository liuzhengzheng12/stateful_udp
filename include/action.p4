action set_op_0() {
    modify_field(sui_meta.op, 0);
}

action set_op_1() {
    modify_field(sui_meta.op, 1);
}

action set_idx_with_hash0() {
    modify_field_with_hash_based_offset(sui_meta.idx, 0, hash0, IDX_SIZE);
}

action set_idx_with_hash1() {
    modify_field_with_hash_based_offset(sui_meta.idx, 0, hash1, IDX_SIZE);
}

action check_ip_port() {
    bit_xor(sui_meta.xor_ip_1, sui_meta.dip, sui_meta.ip_1);
    bit_xor(sui_meta.xor_ip_2, sui_meta.sip, sui_meta.ip_2);
    bit_xor(sui_meta.xor_port, sui_meta.dPort, sui_meta.port);
}

action pass() {
}

action _drop() {
    drop();
}
