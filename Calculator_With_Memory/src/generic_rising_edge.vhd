-------------------------------------------------------------------------------
-- Dr. Kaputa
-- generic counter demo
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;      

entity generic_rising_edge is
  port (
    clk             : in   std_logic; 
    reset           : in   std_logic;
    a               : in   STD_LOGIC;
    output          : out  STD_LOGIC
  );  
end generic_rising_edge;  

architecture beh of generic_rising_edge is
-- signal declarations
signal input_z     : std_logic;
signal input_zz    : std_logic;
signal input_zzz   : std_logic;

begin 
synchronizer: process(reset,clk,a)
  begin
    if reset = '1' then
      input_z     <= '1';
      input_zz    <= '1';
    elsif rising_edge(clk) then
      input_z   <= a;
      input_zz  <= input_z;
    end if;
end process; 

rising_edge_detector: process(reset,clk,input_zz)
  begin
    if reset = '1' then
      output        <= '0';
      input_zzz   <= '1';
    elsif rising_edge(clk) then
      input_zzz   <= input_zz;
      output <= (input_zz xor input_zzz) and input_zz;
    end if;
end process; 
end beh;