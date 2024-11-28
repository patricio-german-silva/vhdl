----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 12:58:28 PM
-- Design Name: 
-- Module Name: ToDisplay - Behavioral
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

entity ToDisplay is
    Generic( POWER_SEL_WIDTH: NATURAL:=7;
             Max: NATURAL := 100000000);    -- Tiemp de ciclo del display
    Port(piTDClk: in STD_LOGIC;
         piTDRst: in STD_LOGIC;
         piTDEna: in STD_LOGIC;
         piTDPowerMD : in STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
         piTDPowerMI: in STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
         piTDMode: in STD_LOGIC;
         poTDData: out STD_LOGIC_VECTOR (3 downto 0);
         poTDDot: out STD_LOGIC;
         poTDK: out STD_LOGIC
         );
end ToDisplay;

architecture A_ToDisplay of ToDisplay is
signal co: STD_LOGIC;
signal cv: STD_LOGIC_VECTOR(2 downto 0);
signal data, dot: UNSIGNED(POWER_SEL_WIDTH-1 downto 0);
begin

instCounter: entity work.Counter(A_Counter)
    generic map(NBitsMax => 28, NBitsVal => 3, Max => Max, NVal => 6) 
    port map(piCTRClk => piTDClk, piCTREna => piTDEna, piCTRRst => piTDRst, poCTRV => cv, poCTRO => co);
    
    process(piTDClk)
    begin
        if cv = "000" then  -- A
            data <= TO_UNSIGNED(10, POWER_SEL_WIDTH);
            dot <= TO_UNSIGNED(0, POWER_SEL_WIDTH);
        elsif cv = "001" then
            data <= UNSIGNED(piTDPowerMD) /10;
            dot <= UNSIGNED(piTDPowerMD) mod 10;
        elsif cv = "010" then  -- B
            data <= TO_UNSIGNED(11, POWER_SEL_WIDTH);
            dot <= TO_UNSIGNED(0, POWER_SEL_WIDTH);
        elsif cv = "011" then
            data <= UNSIGNED(piTDPowerMI) /10;
            dot <= UNSIGNED(piTDPowerMI) mod 10;
        elsif cv = "100" then -- F
            data <= TO_UNSIGNED(15, POWER_SEL_WIDTH);
            dot <= TO_UNSIGNED(0, POWER_SEL_WIDTH);
        elsif cv = "101" then
            if piTDMode = '1' then
                data <= TO_UNSIGNED(1, POWER_SEL_WIDTH);
            else
                data <= TO_UNSIGNED(0, POWER_SEL_WIDTH);
            end if;
            dot <= TO_UNSIGNED(0, POWER_SEL_WIDTH);
        else   -- E
            data <= TO_UNSIGNED(14, POWER_SEL_WIDTH);
            dot <= TO_UNSIGNED(0, POWER_SEL_WIDTH);
        end if;
    end process;

    poTDData <= STD_LOGIC_VECTOR(data(3 downto 0));
    poTDdot <= '0' when dot = TO_UNSIGNED(0, POWER_SEL_WIDTH) else '1';
    poTDK <= co;
    
end A_ToDisplay;

