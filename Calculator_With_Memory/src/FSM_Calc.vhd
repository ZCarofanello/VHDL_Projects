--*************************** VHDL Source Code******************************
--********* Copyright 2016, Rochester Institute of Technology***************
--***************************************************************************
--
-- DESIGNER NAME: Zachary Carofanello
--
-- LAB NAME:Lab 5
--
-- FILE NAME: FSM
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
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FSM_Calc IS
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
END FSM_Calc;

ARCHITECTURE Behave OF FSM_Calc IS
-- signal declarations
constant reset            :STD_LOGIC_VECTOR(3 downto 0):= "0000";
constant ready            :STD_LOGIC_VECTOR(3 downto 0):= "0001";
constant save_to_mem      :STD_LOGIC_VECTOR(3 downto 0):= "0010";
constant recall_from_mem  :STD_LOGIC_VECTOR(3 downto 0):= "0100";
constant execute          :STD_LOGIC_VECTOR(3 downto 0):= "1000";

signal CurrentState      : std_logic_vector(3 downto 0);
signal NextState         : std_logic_vector(3 downto 0);

signal Delay_En, Delay_Flag :STD_LOGIC:='0';
SIGNAL Delay_Value :STD_LOGIC_VECTOR(3 DOWNTO 0):= "0000";

SIGNAL MAX_COUNT       :STD_LOGIC_VECTOR(3 DOWNTO 0):= "0001";
SIGNAL int_count       :STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";

BEGIN   
    The_Current_State <= CurrentState;

    Sync:PROCESS(clk, reset_n) IS
    BEGIN
        IF(reset_n = '0') THEN
            CurrentState <= reset;
        ELSIF(clk'EVENT AND clk = '1') THEN
            CurrentState <= NextState;
        END IF;
    END PROCESS;
        
    ZeCloud:PROCESS(CurrentState, ms_n,mr_n,execute_n) IS
    BEGIN
        CASE (CurrentState) IS
            WHEN ready =>
                IF(ms_n = '1') THEN
                    NextState <= save_to_mem;
                ELSIF(mr_n = '1') THEN
                    NextState <= recall_from_mem; 
                ELSIF(execute_n = '1') THEN
                    NextState <= execute; 
                ELSE
                    NextState <= ready;
                END IF;
			WHEN reset =>
            NextState <= save_to_mem;
            WHEN save_to_mem =>
                --IF(Delay_Flag = '1') THEN
                    NextState <= ready;
                --ELSE
                --    NextState <= save_to_mem;
                --END IF;
            WHEN execute =>
                --IF(Delay_Flag = '1') THEN
                    NextState <= ready;
                --ELSE
                --    NextState <= execute;
                --END IF;
            WHEN recall_from_mem =>
                --IF(Delay_Flag = '1') THEN
                    NextState <= ready;
                --ELSE
                --    NextState <= recall_from_mem;
                --END IF;
            WHEN OTHERS =>
                NextState <= ready;
        END CASE;
    END PROCESS;
    
    Write_Enable_Ctrl:PROCESS(CurrentState) IS
    BEGIN
        IF (CurrentState = ready) THEN
            Mem_we <= '0';
        ELSE
            Mem_we <= '1';
        END IF;
    END PROCESS;
    
    Address_Ctrl:PROCESS(NextState) IS
    BEGIN
        -- CASE (NextState) IS
            -- WHEN ready           => Mem_Addr <= "00";
            -- WHEN save_to_mem     => Mem_Addr <= "00";
            -- WHEN recall_from_mem => Mem_Addr <= "01";
            -- WHEN execute         => Mem_Addr <= "00";
            -- WHEN OTHERS          => Mem_Addr <= "00";
        -- END CASE;
        IF(CurrentState = save_to_mem OR NextState = recall_from_mem) THEN
            Mem_Addr <= "01";
        ELSE
            Mem_Addr <= "00";
        END IF;
    END PROCESS;
    
    Data_Select_Ctrl:PROCESS (CurrentState) IS
    BEGIN
        IF (CurrentState = ready OR CurrentState = execute) THEN
            Dat_Sel <= '0';
        ELSE
            Dat_Sel <= '1';
        END IF;
    END PROCESS;
    
    Delay_Value <= int_count;
    
    -- ZeCounter:PROCESS(clk, reset_n)
    -- BEGIN
        -- IF (reset_n = '0') THEN
            -- int_count <= (OTHERS => '0');
        -- ELSIF(clk'EVENT AND clk = '1') THEN
            -- IF(Delay_En = '1') THEN
                -- IF(int_count = MAX_COUNT) THEN
                    -- int_count <= (OTHERS => '0');
                    -- Delay_Flag <= '1';
                -- ELSE
                    -- int_count <= std_logic_vector(unsigned(int_count) + 1);
                    -- Delay_Flag <= '0';
                -- END IF;
            -- END IF;
        -- END IF;
    -- END PROCESS;
    
END Behave;