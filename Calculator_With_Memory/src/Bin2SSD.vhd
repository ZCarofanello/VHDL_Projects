--*************************** VHDL Source Code******************************
--********* Copyright 2016, Rochester Institute of Technology***************
--***************************************************************************
--
-- DESIGNER NAME: Zachary Carofanello
--
-- LAB NAME:Lab_6
--
-- FILE NAME:Bin2SSD.vhd
--
-------------------------------------------------------------------------------
--
-- DESCRIPTION
--
-- This design will take a 3 bit input and output the corresponding 7 digit 
-- bit array to properly display the character.
--
-------------------------------------------------------------------------------
--
-- REVISION HISTORY
--
-- _______________________________________________________________________
-- |   DATE   |  USER   | Ver | Description |
-- |==========+=========+=====+=============+==============================
-- |          |         |     |             |
-- | 03/07/16 | ZXC5408 | 1.0 | Created     |
-- |
--
--***************************************************************************
--***************************************************************************
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Bin2SSD IS
    PORT(
        bcd             :IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        seven_seg_out   :OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
END Bin2SSD;

ARCHITECTURE Behave OF Bin2SSD IS
						       -- "GFEDCBA"
CONSTANT    H_0:STD_LOGIC_VECTOR:="1000000";
CONSTANT    H_1:STD_LOGIC_VECTOR:="1111001";
CONSTANT    H_2:STD_LOGIC_VECTOR:="0100100";
CONSTANT    H_3:STD_LOGIC_VECTOR:="0110000";
CONSTANT    H_4:STD_LOGIC_VECTOR:="0011001";
CONSTANT    H_5:STD_LOGIC_VECTOR:="0010010";
CONSTANT    H_6:STD_LOGIC_VECTOR:="0000010";
CONSTANT    H_7:STD_LOGIC_VECTOR:="1111000";
CONSTANT    H_8:STD_LOGIC_VECTOR:="0000000";
CONSTANT    H_9:STD_LOGIC_VECTOR:="0010000";
CONSTANT    H_A:STD_LOGIC_VECTOR:="0001000";
CONSTANT    H_b:STD_LOGIC_VECTOR:="0000011";
CONSTANT    H_C:STD_LOGIC_VECTOR:="1000110";
CONSTANT    H_D:STD_LOGIC_VECTOR:="0100001";
CONSTANT    H_E:STD_LOGIC_VECTOR:="0000110";
CONSTANT    H_F:STD_LOGIC_VECTOR:="0001110";
CONSTANT H_Null:STD_LOGIC_VECTOR:="1111111";
BEGIN
	PROCESS (bcd)
	BEGIN
		CASE bcd IS		  
			WHEN "0000"  => seven_seg_out <= H_0;
			WHEN "0001"  => seven_seg_out <= H_1;
			WHEN "0010"  => seven_seg_out <= H_2;
			WHEN "0011"  => seven_seg_out <= H_3;
			WHEN "0100"  => seven_seg_out <= H_4;
			WHEN "0101"  => seven_seg_out <= H_5;
			WHEN "0110"  => seven_seg_out <= H_6;
			WHEN "0111"  => seven_seg_out <= H_7;
			WHEN "1000"  => seven_seg_out <= H_8;
			WHEN "1001"  => seven_seg_out <= H_9;
			WHEN "1010"  => seven_seg_out <= H_A;--A
			WHEN "1011"  => seven_seg_out <= H_b;--b
			WHEN "1100"  => seven_seg_out <= H_C;--C
			WHEN "1101"  => seven_seg_out <= H_D;--D
			WHEN "1110"  => seven_seg_out <= H_E;--E
			WHEN "1111"  => seven_seg_out <= H_F;--F
			WHEN OTHERS  => seven_seg_out <= H_Null;--All off
		END CASE;
	END PROCESS;
END behave;