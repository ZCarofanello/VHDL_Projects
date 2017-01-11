-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic multiply and divide [behavioral]
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_ALU is
  generic (
    bits    : integer := 8
  );
  port (
    a            : in  std_logic_vector(bits-1 downto 0);
    b            : in  std_logic_vector(bits-1 downto 0);
    --cin          : in  std_logic;
    --Outputs
    Operation    : in  std_logic_vector(1 downto 0);
    c            : out std_logic_vector(bits-1 downto 0);
    cout         : out std_logic
  );
end entity generic_ALU;

architecture beh of generic_ALU is
--Arithmatic Operations
constant ADD       :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0000";
constant SUBTRACT  :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0001";
constant MULTIPLY  :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0010";
constant DIVIDE    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0011";
constant NEGATE    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0100";
--Logic Operations                                  
constant NOR_OP    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0101";
constant NAND_OP   :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0110";
constant AND_OP    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0111";
constant OR_OP     :STD_LOGIC_VECTOR(1 DOWNTO 0):= "1000";
constant NOT_OP    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "1001";
--Shifting Operations                               
constant SHIFT_R   :STD_LOGIC_VECTOR(1 DOWNTO 0):= "1010";
constant SHIFT_L   :STD_LOGIC_VECTOR(1 DOWNTO 0):= "1011";

 signal temp : std_logic_vector((bits*2)-1 downto 0);
 
 SIGNAL PaddingBits :STD_LOGIC_VECTOR(bits-1 DOWNTO 0):=(OTHERS => '0');

begin
  
    ALU_Mux:PROCESS(a,b,Operation)
	BEGIN
    CASE (Operation) IS
        --Arithmatic Operations
        WHEN ADD      => temp <= std_logic_vector(unsigned(PaddingBits & a) + unsigned(PaddingBits & b));
        WHEN SUBTRACT => temp <= std_logic_vector(unsigned(PaddingBits & a) - unsigned(PaddingBits & b));
        WHEN MULTIPLY => temp <= std_logic_vector(unsigned(a) * unsigned(b));
        WHEN DIVIDE   => 
        IF (a = b) THEN
          temp <= STD_LOGIC_VECTOR(to_unsigned(1,bits*2));
        ELSE
          temp(bits-1 DOWNTO 0) <= std_logic_vector(unsigned(a) / unsigned(b));
        END IF;
        WHEN NEGATE => temp <= std_logic_vector(unsigned(a) * unsigned(b));
        --Logic Operations
        WHEN NOT_OP => temp <= not(a);
        WHEN AND_OP => temp <= a and b;
        WHEN NAND_OP => temp <= a nand b;
        WHEN OR_OP => temp <= a or b;
        WHEN NOR_OP => temp <= a nor b;
        --Shifting Operations
        WHEN SHIFT_L => temp <= PaddingBits & '0' & a(bits-2 downto 0);
        WHEN SHIFT_R => temp <= PaddingBits & a(bits-1 downto 1) & '0';
        --Catch All
        WHEN OTHERS   => temp <= (OTHERS => '0');
    END CASE;
	END PROCESS;
    
    c <= temp(bits-1 downto 0);
    cout <= temp(bits);
 
end beh;