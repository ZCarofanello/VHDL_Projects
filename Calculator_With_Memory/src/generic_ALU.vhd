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
    cin          : in  std_logic;
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
constant NEGATE    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0000";
--Logic Operations                                  
constant NOR_OP    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0001";
constant NAND_OP   :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0011";
constant AND_OP    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0000";
constant OR_OP     :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0001";
constant NOR_OP    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0010";
constant NOT_OP    :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0011";
--Shifting Operations                               
constant SHIFT_R   :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0000";
constant SHIFT_L   :STD_LOGIC_VECTOR(1 DOWNTO 0):= "0001";

 signal temp : std_logic_vector((bits*2)-1 downto 0);
 
 SIGNAL PaddingBits :STD_LOGIC_VECTOR(bits-1 DOWNTO 0):=(OTHERS => '0');

begin
  
    ALU_Mux:PROCESS(a,b,Operation)
	BEGIN
    CASE (Operation) IS
        WHEN ADD      => temp <= std_logic_vector(unsigned(PaddingBits & a) + unsigned(PaddingBits & b));
        WHEN SUBTRACT => temp <= std_logic_vector(unsigned(PaddingBits & a) - unsigned(PaddingBits & b));
        WHEN MULTIPLY => temp <= std_logic_vector(unsigned(a) * unsigned(b));
        WHEN DIVIDE   => 
        IF (a = b) THEN
          temp <= STD_LOGIC_VECTOR(to_unsigned(1,bits*2));
        ELSE
          temp(bits-1 DOWNTO 0) <= std_logic_vector(unsigned(a) / unsigned(b));
        END IF;
        WHEN OTHERS   => temp <= (OTHERS => '0');
    END CASE;
	END PROCESS;
    
    c <= temp(bits-1 downto 0);
 
end beh;