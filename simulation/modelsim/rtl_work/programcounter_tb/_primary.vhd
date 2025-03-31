library verilog;
use verilog.vl_types.all;
entity programcounter_tb is
    generic(
        bits            : integer := 32
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of bits : constant is 1;
end programcounter_tb;
