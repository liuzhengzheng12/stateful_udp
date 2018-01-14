parser start {
    return parse_ethernet;
}

parser parse_ethernet {
    extract(ethernet);
    return select(latest.ethertype) {
        0X0800 : parse_ipv4;
        default : ingress;
    }
}

parser parse_ipv4 {
    extract(ipv4);
    set_metadata(sui_meta.sip, ipv4.sip);
    set_metadata(sui_meta.dip, ipv4.dip);
    return select(latest.proto) {
        17 : parse_udp;
        default: ingress;
    }
}

parser parse_udp {
    extract(udp);
    set_metadata(sui_meta.sPort, udp.sPort);
    set_metadata(sui_meta.dPort, udp.dPort);
    return ingress;
}
