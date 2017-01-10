-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity generic_synchronizer is
  generic (
    bits       : integer := 3
  );
  port (
    clk             : in   std_logic; 
    reset           : in   std_logic;
    a               : in   std_logic_vector(bits-1 downto 0);
    output          : out  std_logic_vector(bits-1 downto 0)
  );  
end generic_synchronizer;  

architecture beh of generic_synchronizer is
SIGNAL first_ff :STD_LOGIC_VECTOR(bits-1 downto 0):=(Others => '0');

begin
process(clk,reset)
  begin
    if (reset = '1') then 
      output <= (Others => '0');
    elsif (clk'event and clk = '1') then
        first_ff <= a;
        output <= first_ff;
    end if;
  end process;
end beh;