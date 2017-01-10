-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
--USE ieee.std_logic_unsigned.ALL;

entity Mem_Calc_tb is
end Mem_Calc_tb;

architecture arch of Mem_Calc_tb is

COMPONENT Eight_Bit_Calc_Top IS
    PORT(
        clk                                                  :IN  STD_LOGIC;
        reset_n                                              :IN  STD_LOGIC;
        Input                                                :IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        Operation                                            :IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        execute_n                                            :IN  STD_LOGIC;
        ms_n                                                 :IN  STD_LOGIC;
        mr_n                                                 :IN  STD_LOGIC;
        Ones_Display, Tens_Display, Hundreds_Display, Thousands_Display         :OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        Dat_State                                            :OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
end component; 

constant PERIOD        : time := 20ns;                                              
signal clk             : std_logic := '0';
signal reset_n_tb      : std_logic := '0';
signal execute_n_tb    : std_logic := '1';
signal ms_n_tb         : std_logic := '1';
signal mr_n_tb         : std_logic := '1';
signal Input_tb        : std_logic_vector(7 downto 0) := (OTHERS => '0');
signal Operation_tb    : std_logic_vector(1 DOWNTO 0) := (OTHERS => '0');
signal Execute_Sig, Save_Sig, Recall_Sig :STD_LOGIC;

begin
-- input iteration
Test_Cases : process 
    begin
    wait for 4 * PERIOD;
    for k in 0 to 3 loop
      wait for 2 * period;
        for i in 0 to ((2 ** 8) - 1) loop
            Input_tb <= std_logic_vector(unsigned(to_unsigned(0,8)));
            Operation_tb <= "10";
            --Execute!
            execute_n_tb <= '0';
            wait for 4*PERIOD;
            execute_n_tb <= '1';
            --Inputing Data
            wait for 4*PERIOD;
            Input_tb <= std_logic_vector(unsigned(to_unsigned(i,8)));
            Operation_tb <= "00";
            --Execute!
            execute_n_tb <= '0';
            wait for 4*PERIOD;
            execute_n_tb <= '1';
            --Save!
            wait for 4 * PERIOD;
            ms_n_tb <= '0';
            wait for 4*PERIOD;
            ms_n_tb <= '1';
            wait for 6*PERIOD;
            --Onto the next loop
                for j in 0 to ((2 ** 8) - 1)  loop
                  IF((k = 3) AND (i = 0)) THEN
                    wait for PERIOD;
                  ELSE
                      Input_tb <= std_logic_vector(unsigned(to_unsigned(j,8)));
                      Operation_tb <= std_logic_vector(unsigned(to_unsigned(k,2)));
                      --Execute!
                      wait for PERIOD;
                      execute_n_tb <= '0';
                      wait for 4*PERIOD;
                      execute_n_tb <= '1';
                      wait for 4 * PERIOD;
                      --Recall!
                      mr_n_tb <= '0';
                      wait for 4*PERIOD;
                      mr_n_tb <= '1';
                      wait for 2 * PERIOD;
                  END IF;
                end loop;
        end loop;
    end loop;
  end process; 


-- clock process
clock: process
  begin
    clk <= not clk;
    wait for PERIOD/2;
end process; 
 
-- reset process
async_reset: process
  begin
    wait for 2 * PERIOD;
    reset_n_tb <= '1';
    wait;
end process; 

-- Execute: process
    -- begin
        -- if(Execute_Sig = '1') then
            -- execute_n_tb <= '0';
            -- wait for 2*PERIOD;
            -- execute_n_tb <= '1';
            -- Execute_Sig <= '0';
        -- else
            -- execute_n_tb <= '1';
            -- Execute_Sig <= '0';
       -- end if;
	   -- wait;
    -- end process;
    
-- Save_to_Mem: process 
    -- begin
        -- if(Save_Sig = '1') then
            -- ms_n_tb <= '0';
            -- wait for 2*PERIOD;
            -- ms_n_tb <= '1';
            -- Save_Sig <= '0';
        -- else
            -- ms_n_tb <= '1';
            -- Save_Sig <= '0';
       -- end if;
	   -- wait;
    -- end process;
    
-- Recall_from_Mem: process 
    -- begin
        -- if(Recall_Sig = '1') then
            -- mr_n_tb <= '0';
            -- wait for 2*PERIOD;
            -- mr_n_tb <= '1';
            -- Recall_Sig <= '0';
        -- else
            -- mr_n_tb <= '1';
            -- Recall_Sig <= '0';
       -- end if;
	   -- wait;
    -- end process;

uut: Eight_Bit_Calc_Top  
    PORT MAP(
        clk                =>  clk,
        reset_n            =>  reset_n_tb,
        Input              =>  Input_tb,
        Operation          =>  Operation_tb,
        execute_n          =>  execute_n_tb,
        ms_n               =>  ms_n_tb,
        mr_n               =>  mr_n_tb,
        Ones_Display       =>  open,
        Tens_Display       =>  open,
        Hundreds_Display   =>  open,
        Thousands_Display  =>  open,
        Dat_State          =>  open                      
        );
end arch;