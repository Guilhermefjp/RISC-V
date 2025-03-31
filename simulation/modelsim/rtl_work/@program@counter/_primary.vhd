library verilog;
use verilog.vl_types.all;
entity ProgramCounter is
    generic(
        pcen            : integer := 32;
        pcout           : integer := 32
    );
    port(
        clk             : in     vl_logic;
        clr_n           : in     vl_logic;
        load_en         : in     vl_logic;
        pc_next         : in     vl_logic_vector;
        load            : in     vl_logic_vector;
        pc              : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of pcen : constant is 1;
    attribute mti_svvh_generic_type of pcout : constant is 1;
end ProgramCounter;
