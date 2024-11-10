----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2024 04:37:44 PM
-- Design Name: 
-- Module Name: MySecDet - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MySecDet is
    Port (  piClk : in STD_LOGIC;
            piRst : in STD_LOGIC;
            piCtrl : in STD_LOGIC;
            piX : in STD_LOGIC;
            poZ : out STD_LOGIC
    );
end MySecDet;

architecture Behavioral of MySecDet is
Type TStates is (S0, S1, S10, S101);
signal state, next_state: TStates;
begin
    SYNC_PROC : process (piClk)
    begin
        if rising_edge(piClk) then
            if (piRst = '1') then
                state <= S0;
            else
                state <= next_state;
            end if;
        end if; 
    end process;
    
    NEXT_STATE_DECODE : process (state, piX, piCtrl)
    begin
        poZ <= '0';
        case (state) is
            when S0 =>
                if (piX = '1') then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                if (piX = '0') then
                    next_state <= S10;
                else
                    next_state <= S1;
                end if;
            when S10 =>
                if (piX = '1') then
                    next_state <= S101;
                else
                    next_state <= S0;
                end if;
            when S101 =>
                poZ <= '1';
                if (piX = '0') then
                    if piCtrl = '1' then
                        next_state <= S10;
                    else
                        next_state <= S0;
                    end if;
                else
                    next_state <= S1;
                end if;
            when others =>
                next_state <= S0;
        end case;
    end process; 

end Behavioral;
