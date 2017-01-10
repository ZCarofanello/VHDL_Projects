-------------------------------------------------------------------------------
-- Dr. Kaputa
-- components package
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package components is

  COMPONENT double_dabble IS
      PORT(
          Data_In                     :IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
          ones,tens,hundreds,thousands          :OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
          );
  END COMPONENT double_dabble;

  COMPONENT Bin2SSD IS
      PORT(
          bcd             :IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
          seven_seg_out   :OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
          );
  END COMPONENT Bin2SSD;

  COMPONENT generic_synchronizer is
    generic (
      bits       : integer := 3
    );
    port (
      clk             : in   std_logic; 
      reset           : in   std_logic;
      a               : in   std_logic_vector(bits-1 downto 0);
      output          : out  std_logic_vector(bits-1 downto 0)
    );  
  END COMPONENT generic_synchronizer; 

  COMPONENT generic_rising_edge is
  port (
    clk             : in   std_logic; 
    reset           : in   std_logic;
    a               : in   STD_LOGIC;
    output          : out  STD_LOGIC
  );    
  END COMPONENT generic_rising_edge;  
 
 COMPONENT generic_ALU IS
  generic (
    bits    : integer := 8
  );
  port (
    a            : in  std_logic_vector(bits-1 downto 0);
    b            : in  std_logic_vector(bits-1 downto 0);
    Operation    : in  STD_LOGIC_VECTOR(1 DOWNTO 0);
    c            : out std_logic_vector(bits-1 downto 0)
  );
  END COMPONENT generic_ALU;
  
  COMPONENT memory IS
  generic (addr_width : integer := 2;
           data_width : integer := 4);
  port (
    clk               : in std_logic;
    we                : in std_logic;
    addr              : in std_logic_vector(addr_width - 1 downto 0);
    din               : in std_logic_vector(data_width - 1 downto 0);
    dout              : out std_logic_vector(data_width - 1 downto 0)
  );
  end COMPONENT memory;
 
end components;