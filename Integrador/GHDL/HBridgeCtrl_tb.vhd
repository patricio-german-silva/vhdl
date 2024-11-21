----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2024 05:41:18 PM
-- Design Name: 
-- Module Name: HBridgeCtrl_TB - Behavioral
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

entity HBridgeCtrl_TB is
--  Port ( );
end HBridgeCtrl_TB;

architecture Behavioral of HBridgeCtrl_TB is

component HBridgeCtrl is    
    Generic( POWER_SEL_WIDTH: NATURAL:=7;    -- Ancho en bits del selector de PWM
             PWM_DIV: NATURAL:=100;          -- Resolucion del PWM
             PWM_PERIOD: NATURAL:=10000);    -- Cantidad de pulsos de clock para cada unidad de PWM_DIV
    Port(piHBCClk : in STD_LOGIC;
         piHBCRst : in STD_LOGIC;
         piHBCEna : in STD_LOGIC;
         piHBCSet : in STD_LOGIC;
         piHBCDirSel : in STD_LOGIC;
         piHBCPowerSel: in STD_LOGIC_VECTOR (POWER_SEL_WIDTH-1 downto 0);
         poHBCDir : out STD_LOGIC_VECTOR(1 downto 0);
         poHBCPower : out STD_LOGIC
         );
end component HBridgeCtrl;
     
signal clk, rst, ena,set, dirsel, power : std_logic;
signal powersel: std_logic_vector(7-1 downto 0);
signal dir: std_logic_vector(1 downto 0);

begin
    instHBridgeCtrl: HBridgeCtrl
        Generic map( POWER_SEL_WIDTH => 7,
                 PWM_DIV => 10,
                 PWM_PERIOD => 2)
        Port map ( piHBCClk => clk,
                 piHBCRst => rst,
                 piHBCEna => ena,
                 piHBCSet => set,
                 piHBCDirSel => dirsel,
                 piHBCPowerSel => powersel,
                 poHBCDir => dir,
                 poHBCPower => power
                 );

	pClk: process
	begin
		clk <= '1';
		wait for 1 ns;
		clk <= '0';
		wait for 1 ns;
	end process;	

    process
    begin
        rst <= '1';
        set <= '0';
        ena <= '0';
        wait for 5 ns;
        rst <= '0';
        ena <= '1';
        dirsel <= '1';
        powersel <= "0000010";
        wait until falling_edge(clk);
        set <= '1';
        wait until falling_edge(clk);
        set <= '0';
        wait for 400 ns;

        dirsel <= '0';
        powersel <= "0000100";
        wait until falling_edge(clk);
        set <= '1';
        wait until falling_edge(clk);
        set <= '0';
        wait for 400 ns;

        wait;
    end process;


end Behavioral;
