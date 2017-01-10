--*************************** VHDL Source Code******************************
--********* Copyright 2016, Rochester Institute of Technology***************
--***************************************************************************
--
-- DESIGNER NAME: Zachary Carofanello
--
-- LAB NAME:Lab 6
--
-- FILE NAME: Eight_Bit_Calc_Top
--
-------------------------------------------------------------------------------
--
-- DESCRIPTION
--
--    
-- 
-- 
--
-------------------------------------------------------------------------------
--
-- REVISION HISTORY
--
-- _______________________________________________________________________
-- |   DATE   |  USER   | Ver | Description |
-- |==========+=========+=====+=============+==============================
-- |          |         |     |             |
-- | 09/19/16 | ZXC5408 | 1.0 | Created     |
-- |
--
--***************************************************************************
--***************************************************************************
LIBRARY ieee;
LIBRARY work;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.components.ALL;

ENTITY Eight_Bit_Calc_Top IS
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
END Eight_Bit_Calc_Top;

ARCHITECTURE Behave OF Eight_Bit_Calc_Top IS

COMPONENT FSM_Calc IS
    PORT(
        clk                         :IN  STD_LOGIC;
        reset_n                     :IN  STD_LOGIC;
        execute_n                   :IN  STD_LOGIC;
        ms_n                        :IN  STD_LOGIC;
        mr_n                        :IN  STD_LOGIC;
        The_Current_State           :OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Dat_Sel                     :OUT STD_LOGIC;
        Mem_Addr                    :OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        Mem_we                      :OUT STD_LOGIC
        );
END COMPONENT;

SIGNAL reset :STD_LOGIC;
SIGNAL all_ze_buttons :STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL button_flags   :STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Synced_Operation :STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL Synced_Input                                  :STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL Padded_Synced_Input							 :STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL data_from_ram, data_from_alu, data_from_mux   :STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL Where_We_At                                   :STD_LOGIC_VECTOR(3  DOWNTO 0);
SIGNAL Mem_Addr                                      :STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL  Mem_we, Data_Select                          :STD_LOGIC;

SIGNAL ones_bcd, tens_bcd, hundreds_bcd , thousands_bcd :STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
  reset <= not(reset_n);
  all_ze_buttons <= reset_n & execute_n & ms_n & mr_n;
  Dat_State <= Where_We_At;

  data_mux: PROCESS(Data_Select, data_from_alu, data_from_ram)
  BEGIN
       IF(Where_We_At = "0000") THEN
            data_from_mux <= (OTHERS => '0');
       ELSIF(Data_Select = '0') THEN
            data_from_mux <= data_from_alu;
       ELSIF(Data_Select = '1') THEN
            data_from_mux <= data_from_ram;
       ELSE
            data_from_mux <= (OTHERS => '0');
       END IF;
  END PROCESS;
  
  ZeBrains:FSM_Calc
  PORT MAP(
    clk               => clk,
    reset_n           => reset_n,
    execute_n         => button_flags(2),
    ms_n              => button_flags(1),
    mr_n              => button_flags(0),
    The_Current_State => Where_We_At,
    Dat_Sel           => Data_Select,
    Mem_Addr          => Mem_Addr,
    Mem_we            => Mem_we
  );
  
  The_ALU:generic_ALU
  GENERIC MAP(
    bits => 16
  )
  PORT MAP (
    a           => data_from_ram,
    b           => Padded_Synced_Input,
    Operation   => Synced_Operation,
    c           => data_from_alu
  );
    
  Nsync: generic_synchronizer
  GENERIC MAP (
      bits => 8
  )
  PORT MAP(
      clk     => clk,
      reset   => reset,
      a       => Input,
      output  => Synced_Input
  );
  Padded_Synced_Input <= "00000000" & Synced_Input;
  
  Input_Cleansing: generic_synchronizer
  GENERIC MAP (
      bits => 2
  )
  PORT MAP(
      clk     => clk,
      reset   => reset,
      a       => Operation,
      output  => Synced_Operation
  );
    
  Mem_Recall_Sync: generic_rising_edge
  port MAP(
    clk    => clk,
    reset  => reset,
    a      => mr_n,
    output => button_flags(0)
  );
  
  Mem_Save_Sync: generic_rising_edge
  port MAP(
    clk    => clk,
    reset  => reset,
    a      => ms_n,
    output => button_flags(1)
  );
  
  Execute_Sync: generic_rising_edge
  port MAP(
    clk    => clk,
    reset  => reset,
    a      => execute_n,
    output => button_flags(2)
  );
  
  Calc_Memory:memory
  GENERIC MAP (addr_width => 2,
               data_width => 16
   )
  PORT MAP (
    clk     => clk,
    we      => Mem_we,
    addr    => Mem_Addr,
    din     => data_from_mux,
    dout    => data_from_ram
  );
  
  Double_Dabblin:double_dabble
  PORT MAP(
    Data_In    => data_from_ram,               
    ones       => ones_bcd,
    tens       => tens_bcd,
    hundreds   => hundreds_bcd,
    thousands  => thousands_bcd
    );
    
   Ones_Driver:Bin2SSD
   PORT MAP(
    bcd            => ones_bcd,
    seven_seg_out  => Ones_Display
    );
    
   Tens_Driver:Bin2SSD
   PORT MAP(
    bcd            => tens_bcd,
    seven_seg_out  => Tens_Display
    );
    
   Hunds_Driver:Bin2SSD
   PORT MAP(
    bcd            => hundreds_bcd,
    seven_seg_out  => Hundreds_Display
    );
    
   Thousands_Driver:Bin2SSD
   PORT MAP(
    bcd            => thousands_bcd,
    seven_seg_out  => Thousands_Display
    );
    
END Behave;