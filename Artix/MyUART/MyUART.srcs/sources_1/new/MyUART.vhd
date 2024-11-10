----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/08/2024 04:03:04 PM
-- Design Name: 
-- Module Name: MyUART - Behavioral
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
-- Solo recepcion, rs232, sin paridad, sin flow control, 8 bits
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

entity MyUART is
    Generic ( DIV: NATURAL:= 10417);
    Port (  piClk : in STD_LOGIC;
            piUARTRst : in STD_LOGIC;
            piUARTEna : in STD_LOGIC;
            piUARTX : in STD_LOGIC;
            poUARTDRdy: out STD_LOGIC;
            poUARTData : out STD_LOGIC_VECTOR (8-1 downto 0)
    );
end MyUART;

architecture A_MyUART of MyUART is

Type TStates is (S0, S1, S2, S3, S4, S5, S6, S7);
signal state, next_state: TStates;
signal output, tmpdata: UNSIGNED(8-1 downto 0);
signal mcena, mcrst, uartclk, huartclk: STD_LOGIC;

begin

    instBAUDRATEGEN: entity work.ModuleCounter(A_ModuleCounter)
        generic map( NBits => 14, Max => 10)
		port map(piMCClk => piClk, piMCEna => mcena, piMCRst => mcrst, poMCO => uartclk, poMCH => huartclk);

    SYNC_PROC : process (piClk)
    begin
        if rising_edge(piClk) then
            if (piUARTRst = '1') then
                state <= S0;
            else
                state <= next_state;
                mcrst <= '1';
            end if;
        end if; 
    end process;
    
    NEXT_STATE_DECODE : process (state, mcrst, uartclk, huartclk, piUARTX, piUARTEna)
    begin
        output <= TO_UNSIGNED(0, 8);
        case (state) is
            when S0 =>
                if piUARTX = '0' then
                    if piUARTEna = '1' then
                        next_state <= S1;
                        mcrst <= '1';
                    else
                        next_state <= S0;
                    end if;
                end if;
            when S1 =>
                mcrst <= '0';
                if rising_edge(huartclk) then
                    tmpdata(0) <= piUARTX;
                    next_state <= S2;
                else
                    next_state <= S1;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process; 


end A_MyUART;
