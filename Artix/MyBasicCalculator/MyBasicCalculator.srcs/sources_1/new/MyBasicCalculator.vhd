----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2024 06:12:21 PM
-- Design Name: 
-- Module Name: MyBasicCalculator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MyBasicCalculator is
        Port (  piClk : in STD_LOGIC;
                piRst : in STD_LOGIC;
                piWrite : in STD_LOGIC;
                piDataCommand : in STD_LOGIC_VECTOR (8-1 downto 0);
                poRead : out STD_LOGIC;
                poResult : out STD_LOGIC_VECTOR (8-1 downto 0);
                poLedsState : out STD_LOGIC_VECTOR (4-1 downto 0)
        );

end MyBasicCalculator;

architecture A_MyBasicCalculator of MyBasicCalculator is

-- Commands
constant cCMD_INIT: std_logic_vector(8-1 downto 0) := "00000001";
constant cCOD_OP_ADD: std_logic_vector(8-1 downto 0) := "00000010";
constant cCOD_OP_SUB: std_logic_vector(8-1 downto 0) := "00000100";
constant cCOD_OP_OR: std_logic_vector(8-1 downto 0) := "00001000";

type state_type is (S0, S1, S2, S3, S4);

signal state, next_state : state_type;
signal op1, op, op2: std_logic_vector(8-1 downto 0);

begin

    
    SYNC_PROC: process (piClk)
    begin
      if rising_edge(piClk) then
         if (piRst = '1') then
            state <= S0;
         else
            state <= next_state;
         end if;
      end if;
    end process;

    NEXT_STATE_DECODE : process (state, piWrite, piDataCommand, op1, op, op2)
    begin
        poLedsState <= "0001";
        poRead <= '0';
        case (state) is
            when S0 =>  -- Espera INIT
                if (piWrite = '1') and (piDataCommand = cCMD_INIT) then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 => -- Espera 1er operando
                poLedsState <= "0010";
                if piWrite = '1' then
                    next_state <= S2;
                    op1 <= piDataCommand;
                else
                    next_state <= S1;
                end if;
            when S2 => -- Espera operador
                poLedsState <= "0100";
                if piWrite = '1' then
                    next_state <= S3;
                    op <= piDataCommand;
                else
                    next_state <= S2;
                end if;
            when S3 => -- Espera 2do operando
                poLedsState <= "1000";
                if piWrite = '1' then
                    op2 <= piDataCommand;
                    next_state <= S4;
                else
                    next_state <= S3;
                end if;
            when S4 => -- resultado
                poRead <= '1';
                if op = cCOD_OP_ADD then
                    poResult <= std_logic_vector(SIGNED(op1) + SIGNED(op2));
                elsif op = cCOD_OP_SUB then
                    poResult <= std_logic_vector(SIGNED(op1) - SIGNED(op2));
                elsif op = cCOD_OP_OR then
                    poResult <= op1 or op2;
                end if;
                
                if piWrite = '1' then
                    next_state <= S4;
                else
                    next_state <= S0;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process; 
   
end A_MyBasicCalculator;
