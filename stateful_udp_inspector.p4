#include <tofino/intrinsic_metadata.p4>
#include <tofino/stateful_alu_blackbox.p4>

#include "include/macro.p4"
#include "include/header.p4"
#include "include/metadata.p4"
#include "include/parser.p4"
#include "include/hash.p4"
#include "include/action.p4"


register reg_ip_1 {
    width : 32;
    instance_count : REG_INSTANCE_CNT;
}

register reg_ip_2 {
    width : 32;
    instance_count : REG_INSTANCE_CNT;
}

register reg_port {
    width : 16;
    instance_count : REG_INSTANCE_CNT;
}


blackbox stateful_alu update_ip_1_with_sip {
    reg : reg_ip_1;
    update_lo_1_value : sui_meta.sip;
}

blackbox stateful_alu update_ip_2_with_dip {
    reg : reg_ip_2;
    update_lo_1_value : sui_meta.dip;
}

blackbox stateful_alu update_port_with_sPort {
    reg : reg_port;
    update_lo_1_value : sui_meta.sPort;
}

action update_ip_1_with_sip() {
    update_ip_1_with_sip.execute_stateful_alu(sui_meta.idx);
}

action update_ip_2_with_dip() {
    update_ip_2_with_dip.execute_stateful_alu(sui_meta.idx);
}

action update_port_with_sPort() {
    update_port_with_sPort.execute_stateful_alu(sui_meta.idx);
}


blackbox stateful_alu read_ip_1 {
    reg : reg_ip_1;
    update_lo_1_value : register_lo;
    output_value : alu_lo;
    output_dst : sui_meta.ip_1;
}

blackbox stateful_alu read_ip_2 {
    reg : reg_ip_2;
    update_lo_1_value : register_lo;
    output_value : alu_lo;
    output_dst : sui_meta.ip_2;
}

blackbox stateful_alu read_port {
    reg : reg_port;
    update_lo_1_value : register_lo;
    output_value : alu_lo;
    output_dst : sui_meta.port;
}

action read_ip_1() {
    read_ip_1.execute_stateful_alu(sui_meta.idx);
}

action read_ip_2() {
    read_ip_2.execute_stateful_alu(sui_meta.idx);
}

action read_port() {
    read_port.execute_stateful_alu(sui_meta.idx);
}

table set_op_0 {
    actions {
        set_op_0;
    }
    size : 1;
}

table set_op_1 {
    actions {
        set_op_1;
    }
    size : 1;
}

table get_idx {
    reads {
        sui_meta.op : exact;
    }
    actions {
        set_idx_with_hash0;  //op == 0
        set_idx_with_hash1;  //op == 1
    }
    size : 2;
}

table process_reg_ip_1 {
    reads {
        sui_meta.op : exact;
    }
    actions {
        update_ip_1_with_sip;
        read_ip_1;
    }
    size : 2;
}

table process_reg_ip_2 {
    reads {
        sui_meta.op : exact;
    }
    actions {
        update_ip_2_with_dip;
        read_ip_2;
    }
    size : 2;
}

table process_reg_port {
    reads {
        sui_meta.op : exact;
    }
    actions {
        update_port_with_sPort;
        read_port;
    }
    size : 2;
}

table check_ip_port {
    actions {
        check_ip_port;
    }
    size : 1;
}

table dns_filter {
    reads {
        sui_meta.xor_ip_1 : exact;
        sui_meta.xor_ip_2 : exact;
        sui_meta.xor_port : exact;
    }
    actions {
        pass;
        _drop;
    }
    size : 2;
}

control ingress {
    if (sui_meta.dPort == 53) {
        apply(set_op_0);
    }
    else if (sui_meta.sPort == 53) {
        apply(set_op_1);
    }
    apply(get_idx);
    apply(process_reg_ip_1);
    apply(process_reg_ip_2);
    apply(process_reg_port);
    if (sui_meta.sPort == 53) {
        apply(check_ip_port);
        apply(dns_filter);
    }
}

control egress {
}
