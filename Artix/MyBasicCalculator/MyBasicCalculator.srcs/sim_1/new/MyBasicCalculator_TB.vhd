----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2024 06:12:52 PM
-- Design Name: 
-- Module Name: MyBasicCalculator_TB - Behavioral
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

entity MyBasicCalculator_TB is
--  Port ( );
end MyBasicCalculator_TB;

architecture A_MyBasicCalculator_TB of MyBasicCalculator_TB is

component MyBasicCalculator is
        Port (  piClk : in STD_LOGIC;
                piRst : in STD_LOGIC;
                piWrite : in STD_LOGIC;
                piDataCommand : in STD_LOGIC_VECTOR (8-1 downto 0);
                poRead : out STD_LOGIC;
                poResult : out STD_LOGIC_VECTOR (8-1 downto 0);
                poLedsState : out STD_LOGIC_VECTOR (4-1 downto 0)
        );

end component MyBasicCalculator;

signal clk, rst, write, read: STD_LOGIC;
signal datacommand, result: STD_LOGIC_VECTOR (8-1 downto 0);
signal ledsState: STD_LOGIC_VECTOR (4-1 downto 0);

constant cCMD_INIT: std_logic_vector(8-1 downto 0) := "00000001";
constant cCOD_OP_ADD: std_logic_vector(8-1 downto 0) := "00000010";
constant cCOD_OP_SUB: std_logic_vector(8-1 downto 0) := "00000100";
constant cCOD_OP_OR: std_logic_vector(8-1 downto 0) := "00001000";

constant op1: std_logic_vector(8-1 downto 0) := "01001010";
constant op2: std_logic_vector(8-1 downto 0) := "00100110";
begin

    instMyBasicCalculator: MyBasicCalculator
        port map(piClk => clk, piRst => rst, piWrite => write, piDataCommand => dataCommand, poRead => read, poResult => result, poLedsState => ledsState);

	pClk: process
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process;
	
	process
	begin
	rst <= '1';
	write <= '0';
	wait for 33 ns;
	rst <= '0';
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <= cCMD_INIT;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <= op1;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <= cCOD_OP_ADD;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <= op2;
	wait for 33 ns;
	write <= '0';
	wait for 33 ns;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <= cCMD_INIT;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <=  op1;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <= cCOD_OP_SUB;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <=  op2;
	wait for 33 ns;
	write <= '0';
	wait for 33 ns;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <= cCMD_INIT;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <=  op1;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <= cCOD_OP_OR;
	
	wait until falling_edge(clk);
	write <= '1';
	dataCommand <=  op2;
	wait for 33 ns;
	write <= '0';
	
	wait;
	
    end process;
end A_MyBasicCalculator_TB;
