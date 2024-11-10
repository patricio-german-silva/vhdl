----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/01/2024 05:08:18 PM
-- Design Name: 
-- Module Name: MySecDet_TB - Behavioral
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

entity MySecDet_TB is
--  Port ( );
end MySecDet_TB;

architecture A_MySecDet_TB of MySecDet_TB is
component MySecDet is
    Port (  piClk : in STD_LOGIC;
            piRst : in STD_LOGIC;
            piCtrl : in STD_LOGIC;
            piX : in STD_LOGIC;
            poZ : out STD_LOGIC
    );
end component MySecDet;

signal input: STD_LOGIC_VECTOR(24 downto 0);
signal rst, clk, ctrl, x, z: STD_LOGIC;

begin
	instMySecDet: MySecDet
		port map(piClk => clk, piRst => rst, piCtrl => ctrl, piX => x, poZ => z);
		
	
	pClk: process
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process;	
	
    process
    begin
    rst <= '0';
    ctrl <= '0';
    input <= "0000100110001010010101000";
    for i in 0 to 24 loop
        wait until falling_edge(clk);
        x <= input(i);
    end loop;
    
    wait for 20 ns;
    
    ctrl <= '1';
    input <= "0000100110001010010101000";
    for i in 0 to 24 loop
        wait until falling_edge(clk);
        x <= input(i);
    end loop;
    end process;

end A_MySecDet_TB;
